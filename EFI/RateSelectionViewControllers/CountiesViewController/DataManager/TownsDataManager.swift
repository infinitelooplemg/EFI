//
//  TownsDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class TownsDataManager:NSObject,ASTableDataSource ,ASTableDelegate {
    
    weak var tableNode:ASTableNode!
    weak var delegate:StateTownsDelegate!
    var counties:[County]!
    
    init(for tableNode:ASTableNode,from delegate:StateTownsDelegate,data:[County]) {
        super.init()
        self.tableNode = tableNode
        self.delegate = delegate
        self.counties = data
    }
    
    
    
    func tableNode(_ tableNode: ASTableNode, numberOfRowsInSection section: Int) -> Int {
        return counties.count
    }
    
    
    func tableNode(_ tableNode: ASTableNode, nodeBlockForRowAt indexPath: IndexPath) -> ASCellNodeBlock {
        let county = counties[indexPath.row]
        
        // this may be executed on a background thread - it is important to make sure it is thread safe
        let cellNodeBlock = { () -> ASCellNode in
            let cellNode = CountyCellNode(county: county)
            return cellNode
        }
        
        return cellNodeBlock
    }
    
    func tableNode(_ tableNode: ASTableNode, didSelectRowAt indexPath: IndexPath) {        let county = counties[indexPath.row]
        delegate.continueWithSelected(county: county)
    }
}
