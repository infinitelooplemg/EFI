//
//  CCTNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class CCTNode:ASDisplayNode{
    
    override init() {
        super.init()
        // gradientBackground(gradient: gradient)
//        backgroundColor = UIColor.con100tLightGrayColor
       cornerRadius = 5
        borderWidth = 0.5
        borderColor = UIColor.lightGray.cgColor
        automaticallyManagesSubnodes = true
    }
}
