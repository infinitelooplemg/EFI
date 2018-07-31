//
//  RealTimeActivityViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import Foundation
import  AsyncDisplayKit
import Reachability
import Disk
class RealTimeActivityViewController: UIViewController {

    var node:RTActivityNode!
    weak var networkService:CCTApiService?
    var currentMeasurer:Measurer?
    
    
    override func viewDidLoad() {
 
        title = "Instantáneos"
        view.backgroundColor = .white
        node = RTActivityNode()
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
            node.view.leadingAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            node.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
}
