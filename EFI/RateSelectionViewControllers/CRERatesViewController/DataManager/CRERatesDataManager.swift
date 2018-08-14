//
//  CRERatesDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CRERatesDataManager:NSObject,ASTableDataSource,ASTableDelegate {
    var rates:[CRERate]!
    
    weak var delegate:CRERatesDelegate!
    weak var tableNode:ASTableNode!
    
    init(tableNode:ASTableNode,delegate:CRERatesDelegate,data:[CRERate]) {
        super.init()
        self.delegate = delegate
        self.tableNode = tableNode
        self.rates = data
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return rates.count
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let rate = rates[indexPath.row]
        
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = CRERateCellNde(rate: rate)
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        
        let rate = rates[indexPath.row]
        delegate.continueWithSelected(CreRate: rate)
    }
    
    
}

