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

        if editingStyle == .delete {
                    print("borrado")
            let locationToDelete = locations[indexPath.row]
            print(networkService)
            networkService.delete(location: locationToDelete) { [weak self] (response, error) in
          

                if error != nil {
                    self?.viewController.showAlert(with: "No se pudo borrar la localización", message: "Verifica tu conexión a internet y vuelve a intentarlo", image: nil, for: .error)
                    return
                }
                if response?.Codigo == 405 {
                    self?.viewController.showAlert(with: nil, message: response?.Status, image: nil, for: .error)
                } else  {
                    self?.viewController.showAlert(with:"Eliminación Completa", message: "La localización se elimino con exito", image: nil, for: .success)
                    self?.locations.remove(at: indexPath.row)
                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.left)
                }
            }

        }
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
