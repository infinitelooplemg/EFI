//
//  MeasurerAlarmNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 7/30/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import  AsyncDisplayKit

class MeasurerAlarmNode:CCTNode,ASEditableTextNodeDelegate {
    
    var alarmTitleNode:CTTTextNode!
    var maximumDemandTextNode:ASEditableTextNode!
    var percentageTextNode:ASEditableTextNode!
    var switchView:UISwitch!
    var switchNode:ASDisplayNode!
    
    
    
    
    override init() {
        super.init()
        automaticallyManagesSubnodes = true

        alarmTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Alarma")
        alarmTitleNode.style.flexGrow = 0
        maximumDemandTextNode = ASEditableTextNode(placeHolder: "Demanda Maxima Esperada")
        percentageTextNode = ASEditableTextNode(placeHolder: "Porcentaje %")
        percentageTextNode.keyboardType = .decimalPad
        percentageTextNode.delegate = self
        maximumDemandTextNode.delegate = self
        maximumDemandTextNode.keyboardType = .decimalPad
        
        switchNode =  ASDisplayNode { [weak self]() -> UIView in
            self!.switchView = UISwitch()
            self!.switchView.addTarget(self, action: #selector(self!.enable), for: .valueChanged)
            
            return self!.switchView
        }
        switchNode.style.preferredSize = CGSize(width: 51, height: 31)
        switchNode.backgroundColor = .white
        
        maximumDemandTextNode.isHidden = true
        percentageTextNode.isHidden = true
        
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
        maximumDemandTextNode.isHidden = !switchView.isOn
        percentageTextNode.isHidden = !switchView.isOn
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let topStack = ASStackLayoutSpec.horizontal()
        alarmTitleNode.style.flexShrink = 1
        topStack.children = [alarmTitleNode,switchNode]
        topStack.alignItems = .center
        topStack.justifyContent = .spaceBetween
        topStack.style.flexGrow = 1
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [topStack,maximumDemandTextNode,percentageTextNode]
        contentStack.spacing = 8
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetSpecs = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetSpecs
    }
}


