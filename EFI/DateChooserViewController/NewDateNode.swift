//
//  NewDateNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class NewDateNode:CCTNode{
    
    var newDateTitleTextNode:CTTTextNode!
    var newDateTextNode:CTTTextNode!
    
    override init() {
        super.init()
        newDateTitleTextNode = CTTTextNode(withFontSize: 13, color: .black, with: "Nueva Fecha")
        newDateTextNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: "Sin seleccionar")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [newDateTitleTextNode,newDateTextNode]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetspec = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetspec
    }
}
