//
//  StatesViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import AsyncDisplayKit
import Disk
class StatesViewController:ASViewController<ASTableNode>,ASTableDelegate {
    
    var tableNode:ASTableNode!
    var tableManager:StatesTableManager!
    weak var delegate:RateSelectionDelegate!
    weak var networkService:CCTApiService!
    
    
    init(delegate:RateSelectionDelegate,networkService:CCTApiService,states:[State]) {
        self.delegate = delegate
        tableNode = ASTableNode()
        self.networkService = networkService
        super.init(node: tableNode)
        
        tableManager  = StatesTableManager(for: tableNode, delegate: self,data:states)
        tableNode.delegate = tableManager
        tableNode.dataSource = tableManager
        
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = UIColor.white
        tableNode.view.separatorStyle = .singleLine
        
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.setRightBarButton(cancelButton, animated: true)
        title = "Estados"
    }
    
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
}

extension StatesViewController:NationalStatesDelegate {
    func continueWithSelected(state: State) {
        networkService.fetchCounties(by: state) { [weak self] (counties, error) in
            if error != nil {
                return
            }
            let vc = CountiesViewController(delegate:(self?.delegate)!,networkService:(self?.networkService)!,state:state,data:counties!)
            self?.navigationController?.pushViewController(vc, animated: true)
            
        }
        
    }
    
    
    
    
}


