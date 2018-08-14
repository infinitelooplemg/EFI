//
//  CRERateCellNde.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit


class CRERateCellNde:ASCellNode {
    
    var nameTextNode:CTTTextNode!
    var descriptionTextNode:CTTTextNode!
    
    init(rate:CRERate) {
        super.init()
        nameTextNode = CTTTextNode(withFontSize: 25, color: UIColor.black, with: rate.Nombre)
        descriptionTextNode = CTTTextNode(withFontSize: 11, color: UIColor.black, with: rate.Descripcion)
        automaticallyManagesSubnodes  = true
        selectionStyle = .none
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let display = ASDisplayNode()
        display.backgroundColor = UIColor.white
        display.cornerRadius = 5
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        
        let vertitalStack = ASStackLayoutSpec.vertical()
        vertitalStack.children = [nameTextNode,descriptionTextNode]
        vertitalStack.spacing = 4
        
        let internInsetSpecs = ASInsetLayoutSpec(insets: insets, child: vertitalStack)
        
        let background = ASBackgroundLayoutSpec.init(child: internInsetSpecs, background: display)
        
        
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: background)
        
        return insetSpecs
    }
}

