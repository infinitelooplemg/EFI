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
    
    
    var requestTimer:Timer?
    
    override func viewDidLoad() {
 
        title = "Instantáneos"
        view.backgroundColor = UIColor.con100tGrayColor
        node = RTActivityNode(activeMeasurerDelegate: self)
        view.addSubnode(node)
        view.layoutIfNeeded()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
          self.requestTimer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.requestData), userInfo: nil, repeats: true)
        requestTimer?.fire()
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
    
    
    @objc func requestData(){
        networkService?.fetchInstantDataFor(measurer: nil, completion: { [weak self]( responseData, error) in
            
            guard let instanActitivy = responseData else {
                
                return
            }
           
            self!.node.updateValues(RTActivity: instanActitivy)
        })
    }
}

extension RealTimeActivityViewController:ActiveMeasurerNodeDelegate {
    func showMeasurers() {
        networkService?.fetchLocationsList(completion: { (response, error) in
            let vc = UserMeasurersViewController(measurers: (response?.Respuesta)!)
            let nc = UINavigationController(rootViewController: vc)
            
            self.present(nc, animated: true, completion: nil)
            
        })
    }
    
    
}
