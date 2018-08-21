//
//  HistoricalChartOfActitivyDataManager.swift
//  EFI
//
//  Created by LUIS ENRIQUE MEDINA GALVAN on 8/14/18.
//  Copyright © 2018 LUIS ENRIQUE MEDINA GALVAN. All rights reserved.
//


import Foundation
import Charts
class HistoricalChartOfActitivyDataManager:NSObject,IAxisValueFormatter {
    
    weak var chartView:CombinedChartView!
    var charData:CombinedChartData?
    var records:[MeasurerRecord]?
    
    init(chartView:CombinedChartView) {
        super.init()
        self.chartView = chartView
        self.chartView.xAxis.valueFormatter = self
        
        
        
        let l = chartView.legend
        l.wordWrapEnabled = true
        l.horizontalAlignment = .center
        l.verticalAlignment = .bottom
        l.orientation = .horizontal
        l.drawInside = false
        
        let leftAxis = chartView.leftAxis
        leftAxis.axisMinimum = 0
        
        
        
    }
    
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return records![Int(value) % records!.count].HoraRegistro
    }
    
    func show(records:[MeasurerRecord]){
        
        self.records = records
        
        
        charData = CombinedChartData()
        charData?.barData = ProcessBarData()
        charData?.lineData = ProcessLineData()
        chartView.xAxis.axisMaximum = (charData?.xMax)! + 0.25
        chartView.data = charData
        
        let xAxis = chartView.xAxis
        xAxis.labelPosition = .bothSided
        xAxis.axisMinimum = 0
        xAxis.granularity = 1
        xAxis.valueFormatter = self
    }
    
    
    func ProcessLineData() -> LineChartData {
        
        var RPhaseEntries = [ChartDataEntry]()
        var SPhaseEntries = [ChartDataEntry]()
        var TPhaseEntries = [ChartDataEntry]()
        
        
        
        
        
        for index in 1..<records!.count {
            let record = records![index]
            
            let RPhaseEntry = ChartDataEntry(x: Double(index), y: Double(record.Fase1R))
            let SPhaseEntry = ChartDataEntry(x: Double(index), y: Double(record.Fase2T))
            let TPhaseEntry = ChartDataEntry(x: Double(index), y: Double(record.Fase3S))
            RPhaseEntries.append(RPhaseEntry)
            SPhaseEntries.append(SPhaseEntry)
            TPhaseEntries.append(TPhaseEntry)
        }
        
        let set = LineChartDataSet(values: RPhaseEntries, label: "Fase R")
        set.setColor(UIColor.con100tRedColor)
        set.lineWidth = 3
        set.setCircleColor(UIColor.con100tRedColor)
        set.circleRadius = 5
        set.circleHoleRadius = 2.5
        set.fillColor = UIColor.con100tRedColor
        set.mode = .cubicBezier
        set.drawValuesEnabled = true
        set.valueFont = .systemFont(ofSize: 10)
        set.valueTextColor = UIColor.con100tRedColor
        
        set.axisDependency = .left
        
        let set2 = LineChartDataSet(values: SPhaseEntries, label: "Fase S")
        set2.setColor(UIColor.con100tBlueColor)
        set2.lineWidth = 3
        set2.setCircleColor(UIColor.con100tBlueColor)
        set2.circleRadius = 5
        set2.circleHoleRadius = 2.5
        set2.fillColor = UIColor.con100tBlueColor
        set2.mode = .cubicBezier
        set2.drawValuesEnabled = true
        set2.valueFont = .systemFont(ofSize: 10)
        set2.valueTextColor = UIColor.con100tBlueColor
        
        set2.axisDependency = .left
        
        
        let set3 = LineChartDataSet(values: TPhaseEntries, label: "Fase T")
        set3.setColor(UIColor.con100tOrangeColor)
        set3.lineWidth = 3
        set3.setCircleColor(UIColor.con100tOrangeColor)
        set3.circleRadius = 5
        set3.circleHoleRadius = 2.5
        set3.fillColor = UIColor.con100tOrangeColor
        set3.mode = .cubicBezier
        set3.drawValuesEnabled = true
        set3.valueFont = .systemFont(ofSize: 10)
        set3.valueTextColor = UIColor.con100tOrangeColor
        
        set3.axisDependency = .left
        
        return LineChartData(dataSets: [set,set2,set3])
    }
    
    func ProcessBarData() -> BarChartData {
        let entries1 = (0..<records!.count).map { [weak self](i) -> BarChartDataEntry in
            let record = self!.records![i]
            return BarChartDataEntry(x: Double(i), y: Double(record.Calculado))
        }
        
        
        let set1 = BarChartDataSet(values: entries1, label: "Total")
        set1.setColor(UIColor.con100tGrayColor)
        set1.valueTextColor = UIColor.black
        set1.valueFont = .systemFont(ofSize: 10)
        set1.axisDependency = .left
        
        let data = BarChartData(dataSet: set1)
        
        
        
        return data
    }
}
