//
//  BusinessHomeViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class BusinessHomeViewController:UIViewController {
    
    var node:BusinessHomeNode!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
    }
    
    func setupViews(){
        title = "Consumo"
        node = BusinessHomeNode()
        navigationController?.navigationBar.isTranslucent = false
        view.addSubnode(node)
        view.layoutIfNeeded()
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        node.view.translatesAutoresizingMaskIntoConstraints = false
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            node.view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            node.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            node.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            node.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        } else {
            node.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            node.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            node.view.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            node.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}
