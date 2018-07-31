//
//  LocationsViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit
import Disk

class LocationsViewController:ASViewController<ASTableNode> {
    
    var tableNode:ASTableNode!
    var dataManager:LocationsDataManager!
    weak var networkService:CCTApiService?
    
    init(networkService:CCTApiService,locations:[Location]) {
        tableNode = ASTableNode()
        self.networkService = networkService
        super.init(node: tableNode)
        dataManager = LocationsDataManager(tableNode: tableNode, delegate: self, networkService: self.networkService!, viewController: self)
        
        self.dataManager.locations = locations
        self.tableNode.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = .white
        tableNode.view.separatorStyle = .none
        tableNode.allowsSelection = true
        tableNode.view.indicatorStyle = .default
        
        
        extendedLayoutIncludesOpaqueBars = true
        
        title = "Localizaciones"
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension LocationsViewController:LocationCellDelegate {
    
    
    func showMeasurersFor(location: Location) {
        networkService?.fetchMeasurers(for: location, completion: { [weak self] (measurers, error) in
            let vc = MeasurersViewController(measurers: measurers!, location: location, networkService: self!.networkService!)
            vc.networkService = self?.networkService
           self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    
    
    func showConfigurationFor(location: Location, fromIndexPath: IndexPath) {
//        let vc = BusinessLocationViewController()
//        vc.location = location
//        navigationController?.pushViewController(vc, animated: true)
//
    }
    
}
