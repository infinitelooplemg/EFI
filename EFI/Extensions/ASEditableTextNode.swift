//
//  ASEditableTextNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit

extension ASEditableTextNode{
    convenience init(placeHolder:String) {
        self.init()
        let centeredParagraphStyle = NSMutableParagraphStyle()
        centeredParagraphStyle.alignment = .right

        self.attributedPlaceholderText = NSAttributedString(string: placeHolder, attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightGray,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.paragraphStyle:centeredParagraphStyle])
        self.textContainerInset = UIEdgeInsets(top: 4, left: 4, bottom: 4, right: 4)
        self.typingAttributes = [NSAttributedStringKey.foregroundColor.rawValue:UIColor.lightGray,NSAttributedStringKey.font.rawValue:UIFont.boldSystemFont(ofSize: 15),NSAttributedStringKey.paragraphStyle.rawValue:centeredParagraphStyle] 
        
    }
    
    func set(text:String){
        self.attributedText = NSAttributedString(string: text, attributes: [NSAttributedStringKey.foregroundColor:UIColor.lightGray,NSAttributedStringKey.font:UIFont.boldSystemFont(ofSize: 15)])

    }
    
}
