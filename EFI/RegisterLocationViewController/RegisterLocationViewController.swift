//
//  RegisterLocationViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import Disk
class RegisterLocationViewController: UIViewController {
    var scrollNode:ASScrollNode!
    var isRegistering = false
    weak var delegate:RegisterLocationDelegate?
    weak var networkService:CCTApiService?
    
    init(delegate:RegisterLocationDelegate?,networkService:CCTApiService) {
        super.init(nibName: nil, bundle: nil)
        self.delegate = delegate
        self.networkService = networkService
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Nueva Localización"
        scrollNode = RegisterLocationNode(delegate:self, networkService: self.networkService!)
        setupViews()
        view.addSubnode(scrollNode)
        view.backgroundColor = UIColor.con100tGrayColor
        view.layoutIfNeeded()
        
    }
    
    func setupViews(){
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
    }
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        scrollNode.view.translatesAutoresizingMaskIntoConstraints = false
        
        super.viewDidLayoutSubviews()
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            scrollNode.view.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0).isActive = true
            scrollNode.view.bottomAnchor.constraint(equalTo:guide.bottomAnchor, constant: 0).isActive = true
            scrollNode.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: 0).isActive = true
            scrollNode.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: 0).isActive = true
        } else {
            scrollNode.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollNode.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            scrollNode.view.leadingAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            scrollNode.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            
        }
    }
}

extension RegisterLocationViewController:RegisterLocationNodeDelegate{
    func save(location: Location, rate: CRERate, with rateParameters: RateForLocationRequestParameters) {
        var requestParametersForNewLocation = NewLocationRequestParameters()
        requestParametersForNewLocation.ClaveDivisionElectrica = rateParameters.ClaveDivisionElectrica
        requestParametersForNewLocation.ClaveEstado = rateParameters.ClaveEstado
        requestParametersForNewLocation.ClaveEmpresa = rateParameters.ClaveEmpresa
        requestParametersForNewLocation.ClaveTarifaCRE = rateParameters.ClaveTarifaCre
        requestParametersForNewLocation.ClaveMunicipio = rateParameters.ClaveMunicipio
        requestParametersForNewLocation.FinPeriodo = location.FinPeriodo
        requestParametersForNewLocation.InicioPeriodo = location.InicioPeriodo
        requestParametersForNewLocation.ConsumoInicial = location.ConsumoInicial
        requestParametersForNewLocation.Nombre = location.Nombre
        
        
        networkService?.newUserLocation(parameter: requestParametersForNewLocation, completion: { [weak self] (response, error) in
            if error != nil {
//self?.showAlert(with: "Error", message: "Error al conectarse al servidor,verifique su conexión a internet y vuelta a intentarlo", image: nil, for: .success)
                return
            }
            
            if response?.Codigo == 200 {
                let locationToSAVE = response?.Respuesta
                
//                self?.showAlert(with: "Felicidades", message: "Localización agregada correctamente", image: nil, for: .success)
                
                self?.dismiss(animated: true, completion: {
                    self?.delegate?.locationAdded(location: locationToSAVE!,rate: rate)
                })
            }
        })
    }
    
   
}

