//
//  LocationMaximusDemandNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import  AsyncDisplayKit
class LocationMaximusDemandNode:CCTNode,ASEditableTextNodeDelegate {
    
    var maximumDemandTextNode:ASEditableTextNode!
    var maximumDemantTitleNode:CTTTextNode!
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        maximumDemandTextNode = ASEditableTextNode(placeHolder: "0")
        maximumDemandTextNode.keyboardType = .decimalPad
        maximumDemandTextNode.delegate = self
        maximumDemandTextNode.style.flexGrow = 1
        maximumDemantTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Demanda Máxima")
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.children = [maximumDemantTitleNode,maximumDemandTextNode]
        contentStack.alignItems = .center
        contentStack.justifyContent = .spaceBetween
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if editableTextNode.attributedText?.string != "" || text != "" {
            let res = (editableTextNode.attributedText?.string ?? "") + text
            return Float(res) != nil
        }
        return true
    }
}
