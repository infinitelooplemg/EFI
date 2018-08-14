//
//  CRERatesViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class CRERatesViewController:ASViewController<ASTableNode> {
    var tableNode:ASTableNode!
    var dataManager:CRERatesDataManager!
    weak var delegate:RateSelectionDelegate!
    weak var networkService:CCTApiService!
    var requestParameter:RateForLocationRequestParameters!
    var state:State!
    
    
    
    
    
    
    init(delegate:RateSelectionDelegate,networkService:CCTApiService,data:[CRERate],requestParameter:RateForLocationRequestParameters) {
        self.delegate = delegate
        self.requestParameter = requestParameter
        self.networkService = networkService
        tableNode = ASTableNode()
        super.init(node: tableNode)
        dataManager =  CRERatesDataManager(tableNode: tableNode, delegate: self, data: data)
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

extension CRERatesViewController:CRERatesDelegate{
    func continueWithSelected(CreRate: CRERate) {
        
        requestParameter.ClaveTarifaCre = CreRate.Clave
        
        navigationController?.dismiss(animated: true, completion: { [weak self] in
            self?.delegate.rateSelected(rate: CreRate, parameters: self?.requestParameter)
        })
        
    }
    
    
    
    
}

