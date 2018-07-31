//
//  MeasurersViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit
import Reachability

class MeasurersViewController: ASViewController<ASTableNode> {
    var tableNode:ASTableNode!
    var dataManager:MeasurersDataManager!
    weak var networkService:CCTApiService?
    var location:Location!
    
    init(measurers:[Measurer],location:Location,networkService:CCTApiService) {
        tableNode = ASTableNode()
        self.location = location
        self.networkService = networkService
        super.init(node: tableNode)
        extendedLayoutIncludesOpaqueBars = false
        dataManager = MeasurersDataManager(tableNode: tableNode,location:location, networkService: self.networkService!, viewController: self, cellDelegate: self)
        dataManager.measurers = measurers
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = .white
        tableNode.view.separatorStyle = .none
        tableNode.allowsSelection = true
        
        let newLocationBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(registerMeasurer))
        navigationItem.rightBarButtonItem = newLocationBarButton
        
    }
    
    
    @objc func registerMeasurer(){
//        let vc = RegisterMeasurerViewController()
//        vc.location = self.location
//        vc.networkService = networkService
//        present(ASNavigationController( rootViewController: vc), animated: true, completion: nil)
//
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension MeasurersViewController:MeasurerCellNodeDelegate {
    func monitor(measurer: Measurer) {
        print(measurer)
    }
}
