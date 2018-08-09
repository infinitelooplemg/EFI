//
//  DateChooserNode.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import AsyncDisplayKit
import FSCalendar
class DateChooserNode:ASScrollNode{
    
    var calendarNode:ASDisplayNode?
    var saveButton:CCTBorderButtonNode!
    var calendarView:CCTCalendarView!
    var newDateNode:NewDateNode!
    var newDate:Date?
    var previousDateNode:PreviousDateNode?
    var previousDate:Date?
    weak var delegate:DateChooserNodeDelegate!
    
    
    init(delegate:DateChooserNodeDelegate,previousDate:Date?) {
        self.previousDate = previousDate
        
        super.init()
        self.delegate = delegate
        calendarView = CCTCalendarView()
        calendarView.delegate = self
        calendarNode = ASDisplayNode { [weak self]() -> UIView in
            return self!.calendarView
        }
        
        saveButton = CCTBorderButtonNode(fontSize: 15, textColor: .white, with: "Guardar")
        saveButton.addTarget(self, action: #selector(save), forControlEvents: .touchUpInside)
        saveButton.backgroundColor = UIColor.con100tBlueColor
        saveButton.style.height = ASDimension(unit: ASDimensionUnit.points, value: 44)
        
        if self.previousDate != nil {
            
            previousDateNode = PreviousDateNode(previousDate: previousDate!)
        }
        
        newDateNode = NewDateNode()
        calendarNode?.style.preferredSize.height = 300
        
        automaticallyManagesSubnodes = true
        automaticallyManagesContentSize = true
        
        
    }
    
    @objc func save(){
        if let date = newDate {
            delegate.save(date: date)
        }
    }
    
    override func layoutSpecThatFits(_ constrainedSize: ASSizeRange) -> ASLayoutSpec {
        
        let subStack = ASStackLayoutSpec.vertical()
        subStack.alignContent = .center
        subStack.spacing = 8
        
        if previousDateNode != nil {
            subStack.children = [calendarNode!,previousDateNode!,newDateNode]
        } else {
            subStack.children = [calendarNode!,newDateNode]
        }
        
        let contentStack = ASStackLayoutSpec.vertical()
        contentStack.justifyContent = .spaceBetween
        contentStack.children = [subStack,saveButton]
        
        
        let inset = UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8)
        let insetLayoutSpec = ASInsetLayoutSpec(insets: inset, child: contentStack)
        
        return insetLayoutSpec
    }
}

extension DateChooserNode:FSCalendarDelegate{
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        newDate = date
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-dd-MM"
        let dateString = dateFormatter.string(from: date)
        newDateNode.newDateTextNode.changeText(text: dateString)
    }
}





