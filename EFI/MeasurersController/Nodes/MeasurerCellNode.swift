//
//  MeasurerCellNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit

class MeasurerCellNode:ASCellNode {
    
    var measurerTextNode:CTTTextNode!
    var measurerModelTextNode:CTTTextNode!
    var editButton:CCTBorderButtonNode!
    var measurer:Measurer!
    weak var delegate:MeasurerCellNodeDelegate!
    var showHistorialButton:CCTBorderButtonNode!
    
    
    init(measurer:Measurer,delegate:MeasurerCellNodeDelegate) {
        super.init()
        self.delegate = delegate
        selectionStyle = .none
        self.measurer = measurer
        measurerTextNode = CTTTextNode(withFontSize: 20, color: UIColor.black, with: measurer.Nombre!)
        measurerModelTextNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: (measurer.Clave)!)
        editButton = CCTBorderButtonNode(fontSize: 13, textColor: UIColor.con100tBlueColor, with: "Detalles")
        editButton.addTarget(self, action: #selector(edit), forControlEvents: .touchUpInside)
        automaticallyManagesSubnodes  = true
        
        showHistorialButton = CCTBorderButtonNode(fontSize: 13, textColor: .con100tBlueColor, with: "Historial")
        showHistorialButton.addTarget(self, action: #selector(showHistorial), forControlEvents: .touchUpInside)
    }
    
    @objc func edit(){
        delegate.edit(measurer: measurer)
    }
    
    @objc func showHistorial(){
        delegate.showHistorialFor(measurer: measurer)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let textNodesStack = ASStackLayoutSpec.vertical()
        textNodesStack.children = [measurerTextNode,measurerModelTextNode]
        textNodesStack.style.flexShrink = 1
        
        let buttonStack = ASStackLayoutSpec.horizontal()
        buttonStack.children = [showHistorialButton,editButton]
        buttonStack.alignItems = .center
        buttonStack.justifyContent = .spaceAround
        
        let separator = ASDisplayNode()
        separator.style.preferredSize.height = 0.5
        separator.backgroundColor = UIColor.con100tLightGrayColor
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [textNodesStack,separator,buttonStack]
        contentStack.spacing = 8
        
        let display = ASDisplayNode()
        display.backgroundColor = .white
        display.cornerRadius = 5
        display.style.flexGrow = 1
        
        let internalInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: contentStack)
        
        let overlay = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: display)
        
        let insets = UIEdgeInsets(top: 4, left: 8, bottom: 4, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: overlay)
        
        return insetSpecs
    }
}




