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
    var chooseButton:CCTBorderButtonNode!
    var measurer:Measurer!
    weak var delegate:MeasurerCellNodeDelegate!
    
    
    init(measurer:Measurer,delegate:MeasurerCellNodeDelegate) {
        super.init()
        self.delegate = delegate
        selectionStyle = .none
        self.measurer = measurer
        measurerTextNode = CTTTextNode(withFontSize: 20, color: UIColor.lightGray, with: measurer.Nombre!)
        measurerModelTextNode = CTTTextNode(withFontSize: 15, color: UIColor.lightGray, with: (measurer.Clave)!)
        chooseButton = CCTBorderButtonNode(fontSize: 11, textColor: .white, with: "Monitorear")
        chooseButton.addTarget(self, action: #selector(monitor), forControlEvents: .touchUpInside)
        chooseButton.backgroundColor = UIColor.con100tGreenColor
        automaticallyManagesSubnodes  = true
        
        
    }
    
    @objc func monitor(){
        delegate.monitor(measurer: measurer)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let textNodesStack = ASStackLayoutSpec.vertical()
        textNodesStack.children = [measurerTextNode,measurerModelTextNode]
        textNodesStack.style.flexShrink = 1
        
        let contentStack = ASStackLayoutSpec.horizontal()
        contentStack.children = [textNodesStack,chooseButton]
        contentStack.alignItems = .center
        contentStack.justifyContent = .spaceBetween
        
        let display = ASDisplayNode()
        display.backgroundColor = .white
        display.borderWidth = 0.5
        display.cornerRadius = 5
        display.borderColor = UIColor.lightGray.cgColor
        display.style.flexGrow = 1
        
        let internalInsets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let internalInsetSpecs = ASInsetLayoutSpec(insets: internalInsets, child: contentStack)
        
        let overlay = ASBackgroundLayoutSpec(child: internalInsetSpecs, background: display)
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: overlay)
        
        return insetSpecs
    }
}




