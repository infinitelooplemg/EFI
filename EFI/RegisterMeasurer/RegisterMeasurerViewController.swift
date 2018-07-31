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
    var node:ASScrollNode!
    var notification = UINotificationFeedbackGenerator()
    var location:Location?
    
    weak var networkService:CCTApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews() {
        title = "Nuevo Medidor"
        
        scrollNode = RegisterMeasurerNode(delegate:self, location: location!)
        view.addSubnode(scrollNode)
        
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        
        view.layoutIfNeeded()
        view.backgroundColor = .white
    }
}
