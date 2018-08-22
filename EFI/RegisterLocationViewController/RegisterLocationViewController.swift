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
        
        let loadingView = UIView(frame: UIScreen.main.bounds)
        let windows = UIApplication.shared.keyWindow
        loadingView.alpha = 0
        loadingView.backgroundColor = .black
        
        windows?.addSubview(loadingView)
        
        UIWindow.animate(withDuration: 0.5) {
            loadingView.alpha = 0.7
        }
        
        networkService?.newUserLocation(parameter: requestParametersForNewLocation, completion: { [weak self] (response, error) in
            if error != nil {
                UIWindow.animate(withDuration: 0.5) {
                    loadingView.alpha = 0
                }
                self?.showAlert(with: "No se pudo agregar la Localización", message: "Verifica tu conexión a internet y vuelve a intentarlo", image: nil, for: .error)
                self?.dismiss(animated: true, completion: nil)
                return
            }
            
   
            if response?.Codigo == 200 {
               // let locationToSAVE = response?.Respuesta
                UIWindow.animate(withDuration: 0.5) {
                    loadingView.alpha = 0
                }
                self?.showAlert(with: nil, message: "Localización agregada correctamente", image: nil, for: .success)
                
                self?.dismiss(animated: true, completion: {
                //    self?.delegate?.locationAdded(location: locationToSAVE!,rate: rate)
                })
            }
        })
    }
    
    
}

