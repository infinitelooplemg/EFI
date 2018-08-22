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
    
    init(networkService:CCTApiService) {
        tableNode = ASTableNode()
        self.networkService = networkService
        super.init(node: tableNode)
        dataManager = LocationsDataManager(tableNode: tableNode, delegate: self, networkService: self.networkService!, viewController: self)
        
        self.loadLocations()
    }
    
    func loadLocations(){
        networkService?.fetchLocations(completion: { ( locations, error) in
            DispatchQueue.main.async {
                self.dataManager.locations = locations!
                self.tableNode.reloadData()
            }
            
        })
    }
    
    @objc func addLocation(){
        let vc = RegisterLocationViewController(delegate: self, networkService: networkService!)
        present(UINavigationController(rootViewController: vc), animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = UIColor.con100tBackGroundColor
        tableNode.view.separatorStyle = .none
        tableNode.allowsSelection = true
        tableNode.allowsSelectionDuringEditing = true
        tableNode.view.indicatorStyle = .default
        
        title = "Localizaciones"
        if #available(iOS 11.0, *) {
            print("holaaaa")
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
     
        setupNavigationButton()
        
    }
    
    func setupNavigationButton(){
        let newLocationBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addLocation))
        navigationItem.rightBarButtonItem = newLocationBarButton
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}



extension LocationsViewController:LocationCellDelegate {
    func showPaymentStatusFor(location: Location) {
        let vc = PaymentStatusViewController()
        let nc = UINavigationController(rootViewController: vc)
        present(nc, animated: true, completion: nil)
    }
    
    
    
    func showMeasurersFor(location: Location) {
        networkService?.fetchMeasurers(for: location, completion: { [weak self] (measurers, error) in
            let vc = MeasurersViewController(measurers: measurers!, location: location, networkService: self!.networkService!)
            vc.networkService = self?.networkService
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    
    
    func showConfigurationFor(location: Location, fromIndexPath: IndexPath) {
        
    }
    
}

extension LocationsViewController:RegisterLocationDelegate{
    func locationAdded(location: Location, rate: CRERate) {
    
    }
}
