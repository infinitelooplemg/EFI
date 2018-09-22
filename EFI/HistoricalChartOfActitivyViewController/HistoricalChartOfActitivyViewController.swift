//
//  HistoricalChartOfActitivyViewController.swift
//  Ciziem
//
//  Created by Luis Enrique Medina Galvan on 4/15/18.
//  Copyright © 2018 Luis Enrique Medina Galvan. All rights reserved.
//

import Foundation
import Charts
import UIKit

private let ITEM_COUNT = 7

class HistoricalChartOfActitivyViewController:UIViewController{
    var chartView: CombinedChartView!
    var electricalVariablesSegment:UISegmentedControl!
    var date:Date?
    var records:[MeasurerRecord]?
    var dataManager:HistoricalChartOfActitivyDataManager!
    var currentLocation:Location?
    var currentRate:CRERate?
    var currentMeasurer:Measurer?
    
    weak var networkService:CCTApiService?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        electricalVariablesSegment = UISegmentedControl(items: ["V","I","FP","P","Q","S"])
        electricalVariablesSegment.translatesAutoresizingMaskIntoConstraints = false
        electricalVariablesSegment.tintColor = UIColor.con100tBlueColor
        electricalVariablesSegment.addTarget(self, action: #selector(changeElectricalVariable), for: .valueChanged)
        electricalVariablesSegment.selectedSegmentIndex = 0
        
        
        
        view.addSubview(electricalVariablesSegment)
        
        
        if #available(iOS 11.0, *) {
            navigationItem.largeTitleDisplayMode = .never
        }
        
        view.backgroundColor = UIColor.con100tBackGroundColor
        chartView = CombinedChartView(frame:view.frame)
        
        
        chartView.zoomOut()
        setupCharDataManager()
        
        view.addSubview(chartView)
        requestRecordFor(electricalVariable: .voltaje)
        view.layoutIfNeeded()
    }
    func setupCharDataManager(){
        dataManager = HistoricalChartOfActitivyDataManager(chartView: self.chartView)
    }
    
    @objc func changeElectricalVariable(segment:UISegmentedControl){
        let index = segment.selectedSegmentIndex + 1
        print("indicito")





        print(index)
        
        switch index {
        case 1:
            requestRecordFor(electricalVariable: .voltaje)
        case 2:
            requestRecordFor(electricalVariable: .corriente)
        case 3:
            requestRecordFor(electricalVariable: .factorPotencia)
        case 4:
            requestRecordFor(electricalVariable: .potenciaActiva)
        case 5:
            requestRecordFor(electricalVariable: .potenciaReactiva)
        case 6:
            requestRecordFor(electricalVariable: .potenciaAparente)
            
        default:
            print("no programado")
        }
        
        
    }
    
    
    func requestRecordFor(electricalVariable:ElectricalVariables) {
        electricalVariablesSegment.isEnabled = false
        chartView.clear()
        chartView.noDataText = "Cargando Datos"
        
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        
        
        networkService?.fetchHistoricalActivityBy(self.date!, measurer: self.currentMeasurer!, and: electricalVariable, completion: { [weak self] (records, error) in
            if error != nil {
                self?.electricalVariablesSegment.isEnabled = false
                self?.chartView.clear()
                self?.chartView.noDataText = "Al parecer existe un problema de conexión,verifica tu conexión a internet y vuelte a intentarlo"
                self?.chartView.setNeedsDisplay()
                return
            }
            
            guard let results = records else {
                return
            }
            
            if results.count == 0 {
                print(results.count)
                self?.electricalVariablesSegment.isEnabled = false
                self?.chartView.clear()
                self?.chartView.noDataText = "No existen registros para este dia"
                
                return
            }
            self?.electricalVariablesSegment.isEnabled = true
           
            self?.dataManager.show(records: results)
            UIApplication.shared.isNetworkActivityIndicatorVisible = false
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        chartView.xAxis.valueFormatter = nil
    }
    
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            
            electricalVariablesSegment.topAnchor.constraint(equalTo: guide.topAnchor, constant: 8).isActive = true
            electricalVariablesSegment.heightAnchor.constraint(equalToConstant: 30).isActive = true
            electricalVariablesSegment.leadingAnchor.constraint(equalTo: guide.leadingAnchor, constant: 8).isActive = true
            electricalVariablesSegment.trailingAnchor.constraint(equalTo: guide.trailingAnchor, constant: -8).isActive = true
            
            chartView.topAnchor.constraint(equalTo: electricalVariablesSegment.bottomAnchor, constant: 8).isActive = true
            chartView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
            chartView.leadingAnchor.constraint(equalTo: guide.leadingAnchor).isActive = true
            chartView.trailingAnchor.constraint(equalTo: guide.trailingAnchor).isActive = true
        } else {
            electricalVariablesSegment.topAnchor.constraint(equalTo: view.topAnchor, constant: 8).isActive = true
            electricalVariablesSegment.heightAnchor.constraint(equalToConstant: 30).isActive = true
            electricalVariablesSegment.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 8).isActive = true
            electricalVariablesSegment.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -8).isActive = true
            
            chartView.topAnchor.constraint(equalTo: electricalVariablesSegment.bottomAnchor, constant: 8).isActive = true
            chartView.bottomAnchor.constraint(equalTo: view.bottomAnchor).isActive = true
            chartView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
            chartView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        }
    }
    
}




