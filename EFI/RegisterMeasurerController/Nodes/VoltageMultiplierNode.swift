//
//  VoltageMultiplierNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation


import  AsyncDisplayKit

class MeasurerVoltageMultiplierNode:CCTNode ,ASEditableTextNodeDelegate{
    
    var multiplierTitleNode:CTTTextNode!
    var primaryTextNode:ASEditableTextNode!
    var secondaryTextNode:ASEditableTextNode!
    var switchView:UISwitch!
    var switchNode:ASDisplayNode!
    
    
    
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true
       
        multiplierTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Multiplicador de voltaje por uso de Transformador")
        multiplierTitleNode.style.flexGrow = 0
        primaryTextNode = ASEditableTextNode(placeHolder: "Voltaje Primario")
        secondaryTextNode = ASEditableTextNode(placeHolder: "Voltaje Secundario")
        secondaryTextNode.delegate = self
        primaryTextNode.delegate = self
        primaryTextNode.keyboardType = .decimalPad
        secondaryTextNode.keyboardType = .decimalPad
        switchNode =  ASDisplayNode { [weak self]() -> UIView in
            self!.switchView = UISwitch()
            self!.switchView.addTarget(self, action: #selector(self!.enable), for: .valueChanged)
            
            return self!.switchView
        }
        switchNode.style.preferredSize = CGSize(width: 51, height: 31)
        switchNode.backgroundColor = .white
        
        primaryTextNode.isHidden = true
        secondaryTextNode.isHidden = true
        
    }
    
    func editableTextNode(_ editableTextNode: ASEditableTextNode, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if editableTextNode.attributedText?.string != "" || text != "" {
            let res = (editableTextNode.attributedText?.string ?? "") + text
            return Float(res) != nil
        }
        return true
    }
    
    
    @objc func enable(){
        print(switchView.isOn)
        primaryTextNode.isHidden = !switchView.isOn
        secondaryTextNode.isHidden = !switchView.isOn
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topStack = ASStackLayoutSpec.horizontal()
        topStack.children = [multiplierTitleNode,switchNode]
                multiplierTitleNode.style.flexShrink = 1
        topStack.alignItems = .center
        topStack.justifyContent = .spaceBetween
        topStack.style.flexGrow = 1
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [topStack,primaryTextNode,secondaryTextNode]
        contentStack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}


