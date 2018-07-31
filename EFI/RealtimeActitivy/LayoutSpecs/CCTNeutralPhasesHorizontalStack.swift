//
//  CCTNeutralPhasesHorizontalStack.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 30/07/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import  AsyncDisplayKit

class CCTNeutralPhasesHorizontalStack: ASStackLayoutSpec {
    
    var rPhaseCELL:CCTPhaseNode!
    var sPhaseCELL:CCTPhaseNode!
    var tPhaseCELL:CCTPhaseNode!
    var nPhaceCell:CCTPhaseNode!
    
    override init() {
        super.init()
        direction = .horizontal
        rPhaseCELL = CCTPhaseNode(phase: .R)
        sPhaseCELL = CCTPhaseNode(phase: .S)
        tPhaseCELL = CCTPhaseNode(phase: .T)
        nPhaceCell = CCTPhaseNode(phase: .N)
        justifyContent = .spaceBetween
        style.flexGrow = 1.0
        
        
        children = [rPhaseCELL, sPhaseCELL, tPhaseCELL,nPhaceCell]
        
    }
    
    func updatePhases(phases:Phases){
        rPhaseCELL.value.changeText(text: "\(phases.R)")
        sPhaseCELL.value.changeText(text: "\(phases.S)")
        tPhaseCELL.value.changeText(text: "\(phases.T)")
        nPhaceCell.value.changeText(text: "\(phases.N!)")
        
    }
}
