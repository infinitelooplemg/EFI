//
//  MeasurersDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MeasurersDataManager:NSObject,ASTableDataSource,ASTableDelegate {
    var measurers = [Measurer]()
    var location:Location!
    weak var tableNode:ASTableNode!
    weak var networkService:CCTApiService!
    weak var viewController:LocationMeasurersViewController!
    weak var cellDelegate:MeasurerCellNodeDelegate!
    
    init(tableNode:ASTableNode,location:Location,networkService:CCTApiService,viewController:LocationMeasurersViewController,cellDelegate:MeasurerCellNodeDelegate) {
        super.init()
        self.networkService = networkService
        self.cellDelegate = cellDelegate
        self.location = location
        self.viewController = viewController
        self.tableNode = tableNode
        self.tableNode.delegate = self
        self.tableNode.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            
            let measurerToDelete = measurers[indexPath.row]
            
            networkService.delete(measurer: measurerToDelete, for: location) { [weak self] (response, error) in
                
                
                if error != nil {
                    self?.viewController.showAlert(with: "No se pudo borrar el medidor", message: "Verifica tu conexión a internet y vuelve a intentarlo", image: nil, for: .error)
                    return
                }
                if response?.Codigo == 200 {
                    DispatchQueue.main.async {
                        self?.viewController.showAlert(with:"Eliminación Completa", message: "El medidor se elimino con exito", image: nil, for: .success)
                        self?.measurers.remove(at: indexPath.row)
                        tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
                    }
                } else {
                    
                }
                
            }
            
            
        }
    }
    
    
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        let numberOfMeasurers = measurers.count
        return numberOfMeasurers
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        
        
        let measurer = measurers[indexPath.row]
        
        
        let cellNodeBlock = { [weak self] () -> ASCellNode in
            let cellNode = MeasurerCellNode(measurer: measurer,delegate:(self?.cellDelegate)!)
            return cellNode
        }
        
        return cellNodeBlock
        
        
    }
}

