//
//  RTActivelMeasurerNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class RTActivelMeasurerNode:CCTNode  {
    
    var descriptionNode:CTTTextNode!
    var measurerNameNode:CTTTextNode!
    var measurer:Measurer?
    var location:Location?
    var changeMeasurerButton:CCTBorderButtonNode!
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        
        descriptionNode = CTTTextNode(withFontSize: 15, color: UIColor.black, with: "Medidor")
        measurerNameNode = CTTTextNode(withFontSize: 15, color: UIColor.black, with: "Sala de espera")
        
        changeMeasurerButton = CCTBorderButtonNode(fontSize: 13, textColor: .con100tBlueColor, with: "Cambiar")
        changeMeasurerButton.backgroundColor = UIColor.con100tGrayColor
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let textStack = ASStackLayoutSpec.vertical()
        textStack.children = [descriptionNode,measurerNameNode]
        textStack.spacing = 4
        
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.children = [textStack,changeMeasurerButton]
        contentStack.alignItems = .center
        contentStack.justifyContent = .spaceBetween
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
    
}
