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
        cornerRadius = 5
        setTitle(text, with: UIFont.boldSystemFont(ofSize: CGFloat(fontSize)), with: textColor, for: .normal)
        borderWidth = 1
        borderColor = textColor.cgColor
        cornerRadius = 5
        clipsToBounds = true
        contentEdgeInsets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        
    }
}
