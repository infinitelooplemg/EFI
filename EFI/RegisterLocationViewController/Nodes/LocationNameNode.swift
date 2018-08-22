//
//  LocationNameNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import  AsyncDisplayKit

class LocationNameNode:CCTNode {
    
    var locationNmeTextNode:ASEditableTextNode!
    var locationNameTitleNode:CTTTextNode!
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        locationNmeTextNode = ASEditableTextNode(placeHolder: "Nombre")
        locationNmeTextNode.returnKeyType = .done
        locationNmeTextNode.delegate = self
        locationNmeTextNode.textView.textAlignment = .right
        locationNmeTextNode.style.flexGrow = 1
        locationNameTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Localización")
        
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.children = [locationNameTitleNode,locationNmeTextNode]
        contentStack.justifyContent = .spaceBetween
        contentStack.alignItems = .center
    
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom:4 , right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}

extension LocationNameNode:ASEditableTextNodeDelegate {
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            editableTextNode.resignFirstResponder()
            return false
        }
        return true
    }
    
}
