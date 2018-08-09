//
//  CalendarDelegate.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import FSCalendar

class CalendarDelegate:NSObject,FSCalendarDelegate {
    
    weak var delegate:ShowDayDetailDelegate!
    
    init(delegate:ShowDayDetailDelegate) {
        super.init()
        self.delegate = delegate
        
    }
    
    
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        delegate.showDetailfor(date: date)
    }
}
