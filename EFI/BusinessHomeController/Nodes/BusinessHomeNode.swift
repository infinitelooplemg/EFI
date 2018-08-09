//
//  BusinessHomeNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class BusinessHomeNode: ASScrollNode {
    
    var energyConsumptionNode:BusinessEnergyConsumptionNode!
    var paymentStatusNode:PaymentStatusNode!
    var localizationNode:HomeLocationNode!
    var estadoDeCuentaHeader:CTTTextNode!
    
    init(locationNodeDelegate:HomeLocationNodeDelegate) {
        
        super.init()

        paymentStatusNode = PaymentStatusNode()
        paymentStatusNode.style.flexGrow = 1
        localizationNode = HomeLocationNode(delegate: locationNodeDelegate)
        energyConsumptionNode = BusinessEnergyConsumptionNode()
        
        estadoDeCuentaHeader = CTTTextNode(withFontSize: 30, color: .black, with: "Estado de Cuenta")
        
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        backgroundColor = UIColor.con100tGrayColor
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 8
        stack.children = [energyConsumptionNode,paymentStatusNode,localizationNode]
        
        let insets = UIEdgeInsets(top: 8, left: 0, bottom: 8, right: 0)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: stack)
        
        return insetSpecs
    }
}
