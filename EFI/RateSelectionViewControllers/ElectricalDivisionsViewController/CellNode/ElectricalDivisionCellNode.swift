//
//  ElectricalDivisionCellNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/9/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class ElectricalDivisionCellNode:ASCellNode {
    
    var stateTextNode:CTTTextNode!
    
    init(electricalDivision:ElectricalDivision) {
        super.init()
        accessoryType = .disclosureIndicator
        stateTextNode = CTTTextNode(withFontSize: 15, color: UIColor.black, with: electricalDivision.Nombre)
        automaticallyManagesSubnodes  = true
        selectionStyle = .none
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let display = ASDisplayNode()
        display.backgroundColor = UIColor.white
        display.cornerRadius = 5
        
        
        let vertitalStack = ASStackLayoutSpec.vertical()
        vertitalStack.child = stateTextNode
        
        let internInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let internInsetSpecs = ASInsetLayoutSpec(insets: internInsets, child: vertitalStack)
        
        let backGround = ASBackgroundLayoutSpec(child: internInsetSpecs, background: display)
        
        
        
        
        let insets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: backGround)
        
        return insetSpecs
    }
}

