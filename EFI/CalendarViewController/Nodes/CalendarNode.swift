//
//  CalendarNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import AsyncDisplayKit

class CalendarNode:ASScrollNode{
    
    var calendarNode:ASDisplayNode?
    var circleNode:ASDisplayNode!
    var calendarDateColorDescriptionTextNode:CTTTextNode!
    var maximunSpikeNode:CalendarMaximumSpikeOfEnergyNode!
    var dayMaximumComsumptionNode:CalendarDayOfMaximumConsumptionNode!
    
    
    
    init(calendarView:CCTCalendarView) {
        super.init()
        
        calendarNode = ASDisplayNode { () -> UIView in
            return calendarView
        }
        
        calendarNode?.style.preferredSize.height = 300
        
        circleNode = ASDisplayNode()
        circleNode.backgroundColor = UIColor.con100tBlueColor
        circleNode.style.preferredSize = CGSize(width: 18, height: 18)
        circleNode.style.flexGrow = 0
        circleNode.cornerRadius = 9
        
        calendarDateColorDescriptionTextNode = CTTTextNode(withFontSize: 13, color: UIColor.con100tBlueColor, with: "Días comprendidos en el periodo")
        
        maximunSpikeNode = CalendarMaximumSpikeOfEnergyNode()
        dayMaximumComsumptionNode = CalendarDayOfMaximumConsumptionNode()
        
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        
        
    }
    
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let descriptionStack = ASStackLayoutSpec.horizontal()
        descriptionStack.children = [circleNode,calendarDateColorDescriptionTextNode]
        descriptionStack.spacing = 4
        descriptionStack.alignItems = .center
        descriptionStack.style.alignSelf = .end
        
        let stack = ASStackLayoutSpec.vertical()
        stack.alignContent = .center
        stack.style.flexGrow = 1.0
        stack.spacing = 8
        stack.children = [calendarNode!,descriptionStack,maximunSpikeNode,dayMaximumComsumptionNode]
        
        let inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetLayoutSpec = ASInsetLayoutSpec(insets: inset, child: stack)
        
        return insetLayoutSpec
    }
}


class CalendarMaximumSpikeOfEnergyNode:CCTNode{
    
    var maximumSpikeTitleTextNode:CTTTextNode!
    var maximumSpikeTextNode:CTTTextNode!
    
    override init() {
        super.init()
        maximumSpikeTitleTextNode = CTTTextNode(withFontSize: 13, color: .black, with: "Pico Máximo de consumo")
        maximumSpikeTextNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: "123 a las 12:30 del 12/1/2018")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [maximumSpikeTitleTextNode,maximumSpikeTextNode]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetspec = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetspec
    }
}

class CalendarDayOfMaximumConsumptionNode:CCTNode{
    
    var maximumSpikeTitleTextNode:CTTTextNode!
    var maximumSpikeTextNode:CTTTextNode!
    
    override init() {
        super.init()
        maximumSpikeTitleTextNode = CTTTextNode(withFontSize: 13, color: .black, with: "Día de consumo máximo")
        maximumSpikeTextNode = CTTTextNode(withFontSize: 13, color: .lightGray, with: "el 12/12/2018 consumiendo 123 kWh")
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.children = [maximumSpikeTitleTextNode,maximumSpikeTextNode]
        contentStack.spacing = 4
        
        let insets = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetspec = ASInsetLayoutSpec(insets: insets, child: contentStack)
        
        return insetspec
    }
}
