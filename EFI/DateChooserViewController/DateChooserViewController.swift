//
//  DateChooserViewController.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 07/08/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//

import Foundation
import  AsyncDisplayKit
import FSCalendar
class DateChooserViewController:UIViewController{
    
    var scrollNode:ASScrollNode!
    var dateType:DateType!
    var previousDate:Date?
    weak var delegate:DateChooserDelegate!
    
    init(delegate:DateChooserDelegate,dateType:DateType,previousDate:Date?) {
        super.init(nibName: nil, bundle: nil)
        self.previousDate = previousDate
        self.dateType = dateType
        self.delegate = delegate
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        
    }
    
    
    func setupViews(){
        title = "Editar Fecha"
        scrollNode = DateChooserNode(delegate:self,previousDate: previousDate)
        view.addSubnode(scrollNode)
        
        let cancelButton =  UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))
        navigationItem.leftBarButtonItem = cancelButton
        
        view.backgroundColor = UIColor.con100tGrayColor
        view.layoutIfNeeded()
        
    }
    
    
    
    @objc func cancel(){
        dismiss(animated: true , completion: nil)
    }
    
    override func viewDidLayoutSubviews() {
        scrollNode.view.translatesAutoresizingMaskIntoConstraints = false
        super.viewDidLayoutSubviews()
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            scrollNode.view.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
            scrollNode.view.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            scrollNode.view.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
            scrollNode.view.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        } else {
            scrollNode.view.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
            scrollNode.view.leadingAnchor.constraint(equalTo:  view.leadingAnchor).isActive = true
            scrollNode.view.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
            scrollNode.view.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
        }
        
    }
}

extension DateChooserViewController:DateChooserNodeDelegate{
    func save(date: Date) {
        dismiss(animated: true, completion: nil)
        delegate.update(date: date, dateType: dateType)
    }
}


