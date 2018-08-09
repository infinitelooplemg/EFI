//
//  LocationPeriodNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import  AsyncDisplayKit
class LocationPeriodNode:CCTNode {
    
    let titleTextNode:CTTTextNode!
    let startDateTitleNode:CTTTextNode!
    let finishDateTitleNode:CTTTextNode!
    let startDateTextNode:CTTTextNode!
    let finishDateTextNode:CTTTextNode!
    let editFinishDateButtonNode:CTTIconButton!
    let editStartDateButtonNode:CTTIconButton!
    var startDate:Date?
    var finishDate:Date?
    
    weak var delegate:LocationPeriodNodeDelegate!
    
    init(delegate:LocationPeriodNodeDelegate,startDate:Date?,finishDate:Date?) {
        self.delegate = delegate
        self.finishDate = finishDate
        self.startDate = startDate
        titleTextNode = CTTTextNode(withFontSize: 15, color: .black, with: "Periodo Comprendido")
        startDateTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Inicio")
        finishDateTitleNode = CTTTextNode(withFontSize: 15, color: .black, with: "Terminación")
        startDateTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "")
        finishDateTextNode = CTTTextNode(withFontSize: 15, color: .lightGray, with: "")
        
        editStartDateButtonNode = CTTIconButton(icon: #imageLiteral(resourceName: "edit-icon"), size: 20)
        editFinishDateButtonNode = CTTIconButton(icon: #imageLiteral(resourceName: "edit-icon"), size: 20)
        
        
        super.init()
        automaticallyManagesSubnodes = true
        editFinishDateButtonNode.addTarget(self, action: #selector(editFinishDate), forControlEvents: .touchUpInside)
        editStartDateButtonNode.addTarget(self, action: #selector(editStartDate), forControlEvents: .touchUpInside)
    }
    
    @objc func editFinishDate() {
        delegate.initializePeriodConfiguration(dateType: .Finish, previousDate: finishDate)
    }
    
    @objc func editStartDate() {
        delegate.initializePeriodConfiguration(dateType: .Start, previousDate: startDate)
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let display = ASDisplayNode()
        display.backgroundColor = UIColor.white
        
        let startDateInputStack = ASStackLayoutSpec.horizontal()
        startDateInputStack.children = [startDateTextNode,editStartDateButtonNode]
        startDateInputStack.alignItems = .center
        startDateInputStack.spacing = 4
        
        let startDateStack = ASStackLayoutSpec.horizontal()
        startDateStack.children = [startDateTitleNode,startDateInputStack]
        startDateStack.alignItems = .center
        startDateStack.justifyContent = .spaceBetween
        
        let line = ASDisplayNode()
        line.backgroundColor = UIColor.lightGray
        line.style.preferredSize.height = 0.5
        
        
        let finishDateInputStack = ASStackLayoutSpec.horizontal()
        finishDateInputStack.children = [finishDateTextNode,editFinishDateButtonNode]
        finishDateInputStack.alignItems = .center
        finishDateInputStack.spacing = 4
        
        let finishDateStack = ASStackLayoutSpec.horizontal()
        finishDateStack.children = [finishDateTitleNode,finishDateInputStack]
        finishDateStack.alignItems = .center
        finishDateStack.justifyContent = .spaceBetween
        
        let vertical = ASStackLayoutSpec.vertical()
        vertical.children = [titleTextNode,startDateStack,line,finishDateStack]
        vertical.spacing = 8
        
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let inseetSpecs = ASInsetLayoutSpec(insets: insets, child: vertical)
        
        let background = ASBackgroundLayoutSpec(child: inseetSpecs, background: display)
        
        return background
    }
    
}
