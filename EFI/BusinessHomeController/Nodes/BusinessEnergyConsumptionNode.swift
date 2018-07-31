//
//  BusinessEnergyConsumptionNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class BusinessEnergyConsumptionNode:ASDisplayNode {
    
    let baseCell = BasicConsumptionNode()
    let intermediaCell = IntermediateConsumptionNode()
    let puntaCell = TopConsumptionNode()
    let totalCell = TotalConsumptionNode()
    
    var consumoHeaderNode:CTTTextNode!
    
    override init() {
        super.init()
       
        automaticallyManagesSubnodes = true
    }
  
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let w = (UIScreen.main.bounds.width - 24) / 2
        
        baseCell.style.preferredSize.width = w
        intermediaCell.style.preferredSize.width = w
        puntaCell.style.preferredSize.width = w
        totalCell.style.preferredSize.width = w
        
        
        let vertical = ASStackLayoutSpec.horizontal()
        vertical.spacing = 8
        vertical.children = [baseCell,intermediaCell]
        let vertical2 = ASStackLayoutSpec.horizontal()
        vertical2.spacing = 8
        vertical2.children = [puntaCell,totalCell]
        let horizontal = ASStackLayoutSpec.vertical()
        horizontal.spacing = 8
        horizontal.children = [vertical,vertical2]
        return horizontal
    }
    
    
    
}
