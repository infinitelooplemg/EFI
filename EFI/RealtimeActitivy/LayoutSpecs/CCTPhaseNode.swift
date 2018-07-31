//
//  CCTPhaseNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class CCTPhaseNode:ASDisplayNode {
    
    var phase :PhaseIdentifier?
    var icon:ASImageNode!
    var value:CTTTextNode!
    
    init(phase:PhaseIdentifier) {
        
        super.init()
        self.phase = phase
        icon = ASImageNode()
        icon.image = self.phase?.imageDescription
        icon.style.preferredSize = CGSize(width: 30, height: 30)
        icon.contentMode = .scaleAspectFit
        
        style.flexShrink = 1.0
        
        value = CTTTextNode(withFontSize: 18, color: .lightGray, with: "3.00")
        
        
        style.preferredSize.width = 70
        style.preferredSize.height = 70
        automaticallyManagesSubnodes = true
        
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let horizontalStack = ASStackLayoutSpec.vertical()
        horizontalStack.alignItems = .center
        horizontalStack.spacing = 8
        horizontalStack.children = [icon,value]
        
        return horizontalStack
        
    }
}
