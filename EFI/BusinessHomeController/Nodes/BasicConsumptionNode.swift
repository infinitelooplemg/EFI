//
//  BasicConsumptionNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class BasicConsumptionNode:CCTNode{
    let kwTextNode:CTTTextNode!
    let titleTextNode:CTTTextNode!
    
    override init() {
        kwTextNode = CTTTextNode(withFontSize: 30, color: UIColor.lightGray, with: "30,678")
        titleTextNode = CTTTextNode(withFontSize: 15, color: UIColor.black, with: "Base")
        
        super.init()
        
        style.preferredSize.height = 75
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let vertical = ASStackLayoutSpec.vertical()
        vertical.children = [titleTextNode,kwTextNode]
        vertical.justifyContent = .spaceBetween
        vertical.alignItems = .end
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetsSpec = ASInsetLayoutSpec(insets: insets, child: vertical)
        return insetsSpec
    }
}
