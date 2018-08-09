//
//  CCTBorderButton.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//
import AsyncDisplayKit
class CCTBorderButtonNode:ASButtonNode {
    
    init(fontSize:Float,textColor:UIColor,with text:String) {
        super.init()
        setTitle(text, with: UIFont.boldSystemFont(ofSize: CGFloat(fontSize)), with: textColor, for: .normal)
        cornerRadius = 10
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
    }
}
