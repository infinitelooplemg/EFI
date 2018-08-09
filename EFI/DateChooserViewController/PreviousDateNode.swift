//
//  PreviousDateNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class PreviousDateNode:CCTNode{
    
    var previousDateTitleTextNode:CTTTextNode!
    var previousDateTextNode:CTTTextNode!
    
    init(previousDate:Date) {
        super.init()

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        let dateString = dateFormatter.string(from: previousDate)
        
        previousDateTitleTextNode = CTTTextNode(withFontSize: 13, color: .black, with: "Fecha anterior")
        previousDateTextNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: dateString)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [previousDateTitleTextNode,previousDateTextNode]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetspec = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetspec
    }
}
