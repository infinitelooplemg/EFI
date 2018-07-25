//
//  CCTTitleValueHorizontalStack.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class CCTTitleValueHorizontalStack:ASStackLayoutSpec{
    override init() {
        super.init()
        justifyContent = .spaceBetween
        alignItems = .center
        direction = .horizontal
    }
    
    init(title:ASTextNode,subtitle:ASTextNode) {
        super.init()
        justifyContent = .spaceBetween
        alignItems = .center
        direction = .horizontal
        children = [title,subtitle]
    }
}
