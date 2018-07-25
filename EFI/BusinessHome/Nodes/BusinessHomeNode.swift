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
    var localizationNode:LocalizationNode!
    var estadoDeCuentaHeader:CTTTextNode!
    
    override init() {
        
        super.init()

        paymentStatusNode = PaymentStatusNode()
        paymentStatusNode.style.flexGrow = 1
        localizationNode = LocalizationNode()
        energyConsumptionNode = BusinessEnergyConsumptionNode()
        
        estadoDeCuentaHeader = CTTTextNode(withFontSize: 30, color: .black, with: "Estado de Cuenta")
        
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        backgroundColor = UIColor.white
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let stack = ASStackLayoutSpec.vertical()
        stack.spacing = 4
        stack.children = [energyConsumptionNode,paymentStatusNode,localizationNode]
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: stack)
        
        return insetSpecs
    }
}
