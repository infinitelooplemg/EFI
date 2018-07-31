//
//  MeasurerNickNameNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import  AsyncDisplayKit

class MeasurerNickNameNode:CCTNode {
    
    var measurerNickNameTextNode:ASEditableTextNode!
    var measurerNickNameTitleNode:CTTTextNode!
    
    override init() {
        super.init() 
        measurerNickNameTextNode = ASEditableTextNode(placeHolder: "Introduce aqui el nombre")
        measurerNickNameTitleNode = CTTTextNode(withFontSize: 13, color: .black, with: "Nombre de tu medidor")
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [measurerNickNameTitleNode,measurerNickNameTextNode]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}
