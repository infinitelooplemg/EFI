//
//  CCTCalendarView.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import FSCalendar

class CCTCalendarView:FSCalendar {
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCalendar()
    }
    
    func setupCalendar(){
        backgroundColor = UIColor.white
        layer.cornerRadius = 5
        clipsToBounds = true
        appearance.eventDefaultColor = UIColor.con100tBlueColor
        appearance.titleFont = UIFont.boldSystemFont(ofSize: 18)
        appearance.titleDefaultColor = UIColor.con100tBlueColor
        appearance.weekdayTextColor = UIColor.con100tBlueColor
        appearance.headerTitleColor = UIColor.con100tBlueColor
        appearance.headerTitleFont = UIFont.boldSystemFont(ofSize: 18)
        appearance.weekdayFont = UIFont.boldSystemFont(ofSize: 18)
        appearance.selectionColor = UIColor.con100tBlueColor
        appearance.subtitleFont = UIFont.boldSystemFont(ofSize: 11)
        appearance.todayColor = UIColor.systemBlueColor
        appearance.titleTodayColor = UIColor.con100tBlueColor
        appearance.subtitleDefaultColor = UIColor.con100tBlueColor
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
