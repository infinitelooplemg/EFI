//
//  StatesTableManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class StatesTableManager:NSObject,ASTableDataSource,ASTableDelegate {
    
    weak var tableNode:ASTableNode!
    weak var delegate:NationalStatesDelegate!
    var states:[State]!
    
    
    init(for tableNode:ASTableNode,delegate:NationalStatesDelegate,data:[State]) {
        super.init()
        self.states = data
        self.tableNode = tableNode
        
        self.delegate = delegate
    }
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return states.count
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let state = states[indexPath.row]
        
        // this may be executed on a background thread - it is important to make sure it is thread safe
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = StateCellNode(state: state)
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {
        let state = states[indexPath.row]
        delegate.continueWithSelected(state: state)
    }
    
    
    
    
}
