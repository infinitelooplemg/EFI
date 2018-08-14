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
    weak var networkService:CCTApiService?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
     
    }
    
    func setupViews(){
        title = "Consumo"
        node = BusinessHomeNode(locationNodeDelegate: self)
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

extension BusinessHomeViewController:HomeLocationNodeDelegate {
    func showLocations() {
       // let vc = LocationsMapViewController(locations: LocationsMap, nertworkService: )
        //self.navigationController?.pushViewController(vc, animated: true    )
        networkService?.fetchLocations(completion: { [weak self]( locations , error) in

            DispatchQueue.main.async {
                let vc = LocationsViewController(networkService: (self?.networkService!)!, locations: locations!)
               // let vc = LocationsMapViewController(locations: locations!, nertworkService: (self?.networkService!)!)
                self?.navigationController?.pushViewController(vc, animated: true)
            }

        })
    }
}
