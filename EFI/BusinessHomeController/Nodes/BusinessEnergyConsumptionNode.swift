//
//  BusinessEnergyConsumptionNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit


class BusinessEnergyConsumptionNode2:ASDisplayNode {
    let baseCell = BasicConsumptionNode()
    let intermediaCell = IntermediateConsumptionNode()
   
    
    var consumoHeaderNode:CTTTextNode!
    
    init(dmax:Double,Qmensual:Double) {
        super.init()
        baseCell.kwTextNode.changeText(text: String(format: "%.2f", dmax))
        intermediaCell.kwTextNode.changeText(text: String(format: "%.2f", Qmensual))
        baseCell.titleTextNode.changeText(text: "DmaxP")
        intermediaCell.titleTextNode.changeText(text: "QMensual")
       
    
        automaticallyManagesSubnodes = true
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let w = (UIScreen.main.bounds.width - 32) / 2
        
        baseCell.style.preferredSize.width = w
        
        intermediaCell.style.preferredSize.width = w
      
        
        
        let vertical = ASStackLayoutSpec.horizontal()
        vertical.justifyContent = .spaceBetween
        vertical.children = [baseCell,intermediaCell]
    
        let horizontal = ASStackLayoutSpec.vertical()
        horizontal.spacing = 8
        horizontal.children = [vertical]
        return horizontal
    }
}
class BusinessEnergyConsumptionNode:ASDisplayNode {
    
    let baseCell = BasicConsumptionNode()
    let intermediaCell = IntermediateConsumptionNode()
    let puntaCell = TopConsumptionNode()
    let totalCell = TotalConsumptionNode()
    
    var consumoHeaderNode:CTTTextNode!
    
    init(base:Double,mid:Double,top:Double,total:Double) {
        super.init()
        baseCell.kwTextNode.changeText(text: String(format: "%.2f", base))
        intermediaCell.kwTextNode.changeText(text: String(format: "%.2f", mid))
        puntaCell.kwTextNode.changeText(text: String(format: "%.2f", top))
        totalCell.kwTextNode.changeText(text: String(format: "%.2f",total))
        automaticallyManagesSubnodes = true
    }
  
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let w = (UIScreen.main.bounds.width - 32) / 2
        
        baseCell.style.preferredSize.width = w
        
        intermediaCell.style.preferredSize.width = w
        puntaCell.style.preferredSize.width = w
        totalCell.style.preferredSize.width = w
        
        
        let vertical = ASStackLayoutSpec.horizontal()
        vertical.justifyContent = .spaceBetween
        vertical.children = [baseCell,intermediaCell]
        let vertical2 = ASStackLayoutSpec.horizontal()
        vertical2.justifyContent = .spaceBetween
        vertical2.children = [puntaCell,totalCell]
        let horizontal = ASStackLayoutSpec.vertical()
        horizontal.spacing = 8
        horizontal.children = [vertical,vertical2]
        return horizontal
    }
    
    
    
}
