//
//  CTTTextNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/24/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

class CTTTextNode:ASTextNode {
    
    fileprivate var _fontSize:Float!
    fileprivate var _color:UIColor!
    fileprivate var _text:String!
    init(withFontSize:Float,color:UIColor,with text:String) {
        super.init()
        isLayerBacked = true
        cornerRadius = 5
        
        // style.flexGrow = 1
        _fontSize = withFontSize
        _color = color
        _text = text
        attributedText = NSAttributedString(string: _text, attributes: [NSAttributedStringKey.foregroundColor:_color,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: CGFloat(_fontSize!))])
        
    }
    
    
    func changeText(text:String ){
        attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor:_color,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: CGFloat(_fontSize!))])
        
    }
    
}

