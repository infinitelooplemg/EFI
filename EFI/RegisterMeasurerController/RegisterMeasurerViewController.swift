//
//  RegisterMeasurerViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//


import AsyncDisplayKit
import  StatusAlert

class RegisterMeasurerViewController:UIViewController {
    var node:RegisterMeasurerNode!
    var notification = UINotificationFeedbackGenerator()
    var location:Location?
    weak var delegate:RegisterMeasurerDelegate?
    
    weak var networkService:CCTApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        title = "Nuevo Medidor"
        
        node = RegisterMeasurerNode(location: location!)
        node.delegate = self
        view.addSubnode(node)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        
        view.layoutIfNeeded()
        view.backgroundColor = .white
    }
    
    @objc func cancel(){
        dismiss(animated: true, completion: nil)
    }
    override func viewDidLayoutSubviews() {
        node.view.translatesAutoresizingMaskIntoConstraints = false
        super.viewDidLayoutSubviews()
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            node.view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            node.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            node.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            node.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            node.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            node.view.leadingAnchor.constraint(equalTo:  view.leadingAnchor).isActive = true
            node.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            node.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
    }
    
}


extension RegisterMeasurerViewController:RegisterMeasurerNodeDelegate {
    func passParametersFor(measurer: RegisterMeasurerRequestParameters) {
  
        networkService?.newMeasurer(parameter: measurer, completion: { [weak self] (response, error) in

            self?.dismiss(animated: true, completion: {
                
                    self?.delegate?.receiveRegistered(measurer: (response?.Respuesta)!)
                
            })
           
        
            
        })
    }
    
    
}
