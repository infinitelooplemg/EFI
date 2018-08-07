//
//  EmptyMeasurersNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/3/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import AsyncDisplayKit


class EmptyMeasurersCellNode:ASCellNode {
    
    var descriptionNode:CTTTextNode!
    var addMeasurerButton:CCTBorderButtonNode!
    var logoNode:ASImageNode!
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
        selectionStyle = .none
        
        let width = UIScreen.main.bounds.width
        
        descriptionNode = CTTTextNode(withFontSize: 25, color: UIColor.con100tGrayColor, with: "Al parecer no cuentas con ningun EFI registrado")
        
        logoNode = ASImageNode()
        logoNode.image = #imageLiteral(resourceName: "efilogo")
        logoNode.style.flexGrow = 1
        logoNode.style.preferredSize.width = width
        logoNode.style.preferredSize.height = width
        logoNode.contentMode = .scaleAspectFit
        
        addMeasurerButton = CCTBorderButtonNode(fontSize: 25, textColor: UIColor.con100tGrayColor, with: "Registrar EFI")
        addMeasurerButton.borderColor = UIColor.con100tGrayColor.cgColor
        addMeasurerButton.borderWidth = 1
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentLayout = ASStackLayoutSpec.vertical()
        contentLayout.children = [logoNode,descriptionNode,addMeasurerButton]
        contentLayout.spacing = 8

        contentLayout.justifyContent = .center
        contentLayout.style.flexGrow = 1
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentLayout)
        return insetSpecs
    }
}
