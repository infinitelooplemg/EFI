//
//  CTTIconButton.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
class CTTIconButton:ASButtonNode {
    
    init(icon:UIImage,size:Double) {
        super.init()
        setImage(icon, for: .normal)
        style.preferredSize =    CGSize(width: size, height: size)
        imageNode.contentMode = .scaleAspectFit
    }
    
}
