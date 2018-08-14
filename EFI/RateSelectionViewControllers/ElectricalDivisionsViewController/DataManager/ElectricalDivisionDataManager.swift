//
//  ElectricalDivisionDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ElectricalDivisionDataManager:NSObject,ASTableDataSource ,ASTableDelegate {
    
    weak var tableNode:ASTableNode!
    weak var delegate:ElectricalDivisionDelegate!
    var electricalDivisions:[ElectricalDivision]!
    
    init(tableNode:ASTableNode, delegate:ElectricalDivisionDelegate,data:[ElectricalDivision]) {
        super.init()
        self.tableNode = tableNode
        self.delegate = delegate
        self.electricalDivisions = data
    }
    
    
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return electricalDivisions.count
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let electricalDivision = electricalDivisions[indexPath.row]
        
        // this may be executed on a background thread - it is important to make sure it is thread safe
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = ElectricalDivisionCellNode(electricalDivision: electricalDivision)
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let electricalDivision = electricalDivisions[indexPath.row]
        delegate.continueWithSelected(electricalDivision: electricalDivision)
    }
}


