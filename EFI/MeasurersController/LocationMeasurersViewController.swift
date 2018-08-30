//
//  MeasurersViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit
import Reachability

class LocationMeasurersViewController: ASViewController<ASTableNode> {
    var tableNode:ASTableNode!
    var dataManager:MeasurersDataManager!
    weak var networkService:CCTApiService?
    var location:Location!
    var measurers:[Measurer]!
    
    init(measurers:[Measurer],location:Location,networkService:CCTApiService) {
        tableNode = ASTableNode()
        self.measurers = measurers
        self.location = location
        self.networkService = networkService
        super.init(node: tableNode)
        extendedLayoutIncludesOpaqueBars = false
        
        dataManager = MeasurersDataManager(tableNode: tableNode,location:location, networkService: self.networkService!, viewController: self, cellDelegate: self)
        dataManager.measurers = measurers
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableNode.backgroundColor = UIColor.con100tBackGroundColor
        tableNode.view.separatorStyle = .none
        tableNode.allowsSelection = true
        
        navigationItem.title = "Medidores"
        
        let newLocationBarButton = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(registerMeasurer))
        navigationItem.rightBarButtonItem = newLocationBarButton
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if measurers.count == 0 {
            askForMeasurerRegistration()
        }
    }
    
    
    @objc func registerMeasurer(){
        let vc = MeasurerConfigurationViewController(location: self.location)
        vc.delegate = self
        vc.networkService = networkService
        present(ASNavigationController( rootViewController: vc), animated: true, completion: nil)
        
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func askForMeasurerRegistration(){
        
        let alert = UIAlertController(title: "Atención", message: "Al parecer no cuenta con ningun EFI registrado en \(self.location.Nombre!)", preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Registrar un EFI", comment: ""), style: .default, handler: { [weak self] _ in
            let vc = MeasurerConfigurationViewController(location: (self?.location)!)
            vc.delegate = self
            vc.networkService = self?.networkService
            self?.present(ASNavigationController( rootViewController: vc), animated: true, completion: nil)
        }))
        
        alert.addAction(UIAlertAction(title: NSLocalizedString("Cancelar", comment: ""), style: .cancel, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
}

extension LocationMeasurersViewController:MeasurerCellNodeDelegate {
    func showHistorialFor(measurer: Measurer) {
        let vc = CalendarViewController()
        vc.currentLocation = location
        vc.currentMeasurer = measurer
        vc.networkService = self.networkService
        let nc = UINavigationController(rootViewController: vc)
        
        present(nc, animated: true, completion: nil)
    }
    
    func edit(measurer: Measurer) {
        let vc = MeasurerConfigurationViewController(location: self.location, measurer: measurer)
        vc.delegate = self
        vc.networkService = self.networkService
        self.present(ASNavigationController( rootViewController: vc), animated: true, completion: nil)
    }
     
}

extension LocationMeasurersViewController:RegisterMeasurerDelegate {
    func receiveRegistered(measurer: Measurer) {
        dataManager.measurers.append(measurer)
        DispatchQueue.main.async { [weak self] in
            self?.tableNode.reloadData()
        }
        
    }
    
    
}
