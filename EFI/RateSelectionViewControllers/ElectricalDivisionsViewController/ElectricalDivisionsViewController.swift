//
//  ElectricalDivisionsViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import AsyncDisplayKit

class ElectricalDivisionsViewController:ASViewController<ASTableNode> {
    var tableNode:ASTableNode!
    var dataManager:ElectricalDivisionDataManager!
    weak var delegate:RateSelectionDelegate!
    var state:State!
    var county:County!
    weak var networkService:CCTApiService!
    
    
    
    init(delegate:RateSelectionDelegate,state:State,county:County,networkService:CCTApiService,data:[ElectricalDivision]) {
        self.delegate = delegate
        self.state = state
        self.county = county
        self.networkService = networkService
        
        
        
        
        tableNode = ASTableNode()
        
        super.init(node: tableNode)
        dataManager = ElectricalDivisionDataManager(tableNode: tableNode,delegate: self, data: data)
        tableNode.dataSource = dataManager
        tableNode.delegate = dataManager
        fetchData()
    }
    
    func fetchData(){
        networkService.fetchElectricalDivision(by: state, county: county) { [weak self] (divisions, responseError) in
            if let error =  responseError {
                print(error)
            } else {
                self?.dataManager.electricalDivisions = divisions!
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = .white
        tableNode.view.separatorStyle = .singleLine
        
        title = "Divisiones Electricas"
        
        
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


extension ElectricalDivisionsViewController: ElectricalDivisionDelegate {
    func continueWithSelected(electricalDivision: ElectricalDivision) {
        
        let loadingView = UIView(frame: UIScreen.main.bounds)
        let window = UIApplication.shared.keyWindow
        loadingView.backgroundColor = .black
        loadingView.alpha = 0
        
        window?.addSubview(loadingView)
        
        UIWindow.animate(withDuration: 0.5) {
            loadingView.alpha = 0.7
        }
        
        networkService.fetchCRERates { [weak self] (rates, error) in
            if error != nil {
                return
            }
            
            var requestParameters = RateForLocationRequestParameters()
            requestParameters.ClaveEstado = self?.state.Clave
            requestParameters.ClaveMunicipio = self?.county.Clave
            requestParameters.ClaveDivisionElectrica = electricalDivision.Clave
            
            let vc = CRERatesViewController(delegate: (self?.delegate)!, networkService: (self?.networkService)!, data: rates!,requestParameter:requestParameters)
            self?.navigationController?.pushViewController(vc, animated: true)
            UIWindow.animate(withDuration: 0.5) {
                loadingView.alpha = 0
            }
        }
        
    }
}

