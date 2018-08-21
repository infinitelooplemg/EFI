//
//  LocationsDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import  AsyncDisplayKit
class LocationsDataManager:NSObject,ASTableDataSource ,ASTableDelegate {
    
    var locations = [Location]()
    
    weak var tableNode:ASTableNode!
    weak var delegate:LocationCellDelegate!
    weak var networkService:CCTApiService!
    weak var viewController:LocationsViewController!
    

    init(tableNode:ASTableNode,delegate:LocationCellDelegate,networkService:CCTApiService,viewController:LocationsViewController) {
        self.tableNode = tableNode
        self.delegate = delegate
        self.viewController = viewController
        self.networkService = networkService
        super.init()
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
        
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
//        if editingStyle == .delete {
//            let locationToDelete = locations[indexPath.row]
//            networkService.delete(location: locationToDelete) { [weak self] (response, error) in
//
//                if error != nil {
//                    return
//                }
//                if response?.Codigo == ResponseCode.Error.rawValue {
//                    self?.viewController.showAlert(with: "ERROR", message: "Esta localización contiene medidores,no puede ser borrada", image: nil, for: .error)
//                } else  {
//                    self?.viewController.showAlert(with:"Eliminacion Completa", message: "La localización se elimino con exito", image: nil, for: .success)
//                    self?.locations.remove(at: indexPath.row)
//                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
//                }
//            }
//
//        }
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func numberOfSections(in tableNode: ASTableNode) -> Int {
        return 1
    }
    
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return locations.count
        
    }
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        let location = locations[indexPath.row]
        
        let cellNodeBlock = { [weak self]() -> ASCellNode in
            let cellNode = LocationCellNode(location: location)
            
            cellNode.delegate = self!.delegate
            return cellNode
        }
        
        return cellNodeBlock
    }
    
}
