//
//  CalendarViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import AsyncDisplayKit
import FSCalendar

class CalendarViewController:UIViewController {
    var segmentedController: UISegmentedControl!
    var scrollNode:ASScrollNode!
    var calendarView:CCTCalendarView!
    var calendarDataSource:CalendarDataSource!
    var calendarDelegate:CalendarDelegate!
    var currentLocation:Location?
    var currentRate:CRERate?
    var currentMeasurer:Measurer?
    weak var networkService:CCTApiService!
    let selection = UISelectionFeedbackGenerator()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.con100tGrayColor
        
        calendarView = CCTCalendarView()
        wireDelegation()
        
        scrollNode = CalendarNode(calendarView: calendarView)
        scrollNode.view.alwaysBounceVertical = true
        
        view.addSubnode(scrollNode)
        view.layoutIfNeeded()
        
        title = "Consumo kWh"
        
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        }
        
        
    }
    
    func wireDelegation() {
        
        calendarDataSource = CalendarDataSource()
        calendarView.dataSource = calendarDataSource
        
        calendarDelegate = CalendarDelegate(delegate: self)
        calendarView.delegate = calendarDelegate
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        scrollNode.view.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            scrollNode.view.topAnchor.constraint(equalTo: guide.topAnchor,constant: 0).isActive = true
            scrollNode.view.bottomAnchor.constraint(equalTo:guide.bottomAnchor, constant: 0).isActive = true
            scrollNode.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor,constant: 0).isActive = true
            scrollNode.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor,constant: 0).isActive = true
        } else {
            scrollNode.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollNode.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            scrollNode.view.leadingAnchor.constraint(equalTo: view.leftAnchor).isActive = true
            scrollNode.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
        
    }
    
    
    
}

extension CalendarViewController:ShowDayDetailDelegate{
    func showDetailfor(date: Date) {
//        selection.selectionChanged()
//        let vc = HistoricalChartOfActitivyViewController()
//        vc.networkService = self.networkService
//        vc.date = date
//        vc.hidesBottomBarWhenPushed = true
//        vc.currentRate = self.currentRate
//        vc.currentMeasurer = self.currentMeasurer
//        vc.currentLocation = self.currentLocation
//        navigationController?.pushViewController(vc, animated: true)
        
    }
}

