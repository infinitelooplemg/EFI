//
//  CalendarDataSource.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation

import Foundation
import FSCalendar
class CalendarDataSource:NSObject,FSCalendarDataSource {
    
    
    override init() {
        super.init()
        
    }
    
    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
        
        let randomNumber = Int(arc4random_uniform(10))
        return "\(randomNumber)"
        
    }
    
//    //the date format "yyyy-MM-dd"
//    func maximumDate(for calendar: FSCalendar) -> Date {
//        return Date(dateString: "2018-05-30")
//    }
//    
//    func minimumDate(for calendar: FSCalendar) -> Date {
//        return Date(dateString: "2018-04-20")
//    }
    
    
    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {
        
        if date == Date(dateString: "2018-03-28") || date == Date(dateString: "2018-02-18"){
            return 1}
        else {
            return 0
        }
    }
    
    
}
