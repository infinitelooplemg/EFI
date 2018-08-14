//
//  CountiesViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import AsyncDisplayKit

class CountiesViewController:ASViewController<ASTableNode> {
    var tableNode:ASTableNode!
    var dataManager:TownsDataManager!
    weak var delegate:RateSelectionDelegate!
    weak var networkService:CCTApiService!
    var state:State!
    
    
    
    
    
    
    init(delegate:RateSelectionDelegate,networkService:CCTApiService,state:State,data:[County]) {
        self.delegate = delegate
        self.state = state
        self.networkService = networkService
        tableNode = ASTableNode()
        super.init(node: tableNode)
        dataManager =  TownsDataManager(for: tableNode, from: self, data: data)
        tableNode.dataSource = dataManager
        tableNode.delegate = dataManager
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = .white
        tableNode.view.separatorStyle = .singleLine
        title = "Municipios"
        
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.setRightBarButton(cancelButton, animated: true)
        
    }
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension CountiesViewController:StateTownsDelegate {
    func continueWithSelected(county: County) {
        let loadingView = UIView(frame: UIScreen.main.bounds)
        let window = UIApplication.shared.keyWindow
        loadingView.backgroundColor = .black
        loadingView.alpha = 0
        
        window?.addSubview(loadingView)
        
        UIWindow.animate(withDuration: 0.5) {
            loadingView.alpha = 0.7
        }
        networkService.fetchElectricalDivision(by: state, county: county) { [weak self] (divisions, responseError) in
            if let error =  responseError {
                print(error)
            } else {
                let vc = ElectricalDivisionsViewController(delegate: (self?.delegate!)!, state: (self?.state!)!, county: county, networkService: (self?.networkService)!, data: divisions!)
                self?.navigationController?.pushViewController(vc, animated: true)
            }
            
            UIWindow.animate(withDuration: 0.5) {
                loadingView.alpha = 0
            }
        }
        
    }
    
    
}

