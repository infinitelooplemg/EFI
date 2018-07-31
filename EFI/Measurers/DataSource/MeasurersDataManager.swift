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
    weak var viewController:MeasurersViewController!
    weak var cellDelegate:MeasurerCellNodeDelegate!
    
    init(tableNode:ASTableNode,location:Location,networkService:CCTApiService,viewController:MeasurersViewController,cellDelegate:MeasurerCellNodeDelegate) {
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
            measurers.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
            
            //            networkService.delete(measurer: measurerToDelete, for: location) { [weak self] (response, error) in
            //                if error != nil {
            //                    self?.viewController.showAlert(with:"Error de Conexión", message: "Verifique su conexión a internet y vuelva a intentarlo", image: nil,for: .error)
            //                    return
            //                }
            //                if response?.Codigo == 200 {
            //                    self?.measurers.remove(at: indexPath.row)
            //                    tableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.right)
            //                    self?.viewController.showAlert(with:"Eliminación Completa", message: "El medidor se elimino de la localizacion correctamente", image: nil, for: .success)
            //                } else {
            //                    self?.viewController.showAlert(with:"Error", message: (response?.Status)!, image: nil, for: .error)
            //                }
            //            }
            
            
        }
    }
    
    
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return measurers.count
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let measurer = measurers[indexPath.row]
        
        // this may be executed on a background thread - it is important to make sure it is thread safe
        let cellNodeBlock = { [weak self] () -> ASCellNode in
            let cellNode = MeasurerCellNode(measurer: measurer,delegate:(self?.cellDelegate)!)
            return cellNode
        }
        
        return cellNodeBlock
    }
}

