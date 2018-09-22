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
        networkService?.fetchLocations(completion: { [weak self]( locations, error) in
            
            if error != nil {
                self?.showAlert(with: "No fue posible recibir los datos", message: "Verifica tu conexión a internet y vuelve a intentarlo", image: nil, for: .error)
                return
            }
            
            guard let locations = locations else {
                return
            }
            DispatchQueue.main.async {
                self?.dataManager.insertNewLocations(locations)
                self?.tableNode.reloadData()
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
        networkService?.energyConsumptionfor(location: location, completion: { [weak self](energyConsumption, error) in
            if error != nil {
                print(error)
                return
            }
            
            let vc = PaymentStatusViewController(energyConsumption: energyConsumption!)
            let nc = UINavigationController(rootViewController: vc)
            self?.present(nc, animated: true, completion: nil)
        })
       
    }
    
    
    
    func showMeasurersFor(location: Location) {
        networkService?.fetchMeasurers(for: location, completion: { [weak self] (measurers, error) in
            
            if error != nil {
                self?.showAlert(with: "No fue posible recibir los datos", message: "Verifica tu conexión a internet y vuelve a intentarlo", image: nil, for: .error)
                return
            }
            
            guard let measurers = measurers else {
                return
            }
            
            let vc = LocationMeasurersViewController(measurers: measurers, location: location, networkService: self!.networkService!)
            vc.networkService = self?.networkService
            self?.navigationController?.pushViewController(vc, animated: true)
        })
    }
    
    
    
    func showDetailsFor(location: Location, fromIndexPath: IndexPath) {

        let vc = LocationDetailViewController(location: location)
        let nc = UINavigationController(rootViewController: vc)
        
        self.present(nc, animated: true, completion: nil)
    }
    
}

extension LocationsViewController:RegisterLocationDelegate{
    func locationAdded(location: Location, rate: CRERate) {
        
    }
}
