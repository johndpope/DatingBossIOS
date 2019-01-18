//
//  RadarChartTestViewController.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 18/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import Charts

class RadarChartTestViewController: UIViewController {
    private let chartView = RadarChartView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.backgroundColor = .white
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.delegate = self
        chartView.chartDescription?.enabled = false
        
        let xAxis = chartView.xAxis
        xAxis.forceLabelsEnabled = false
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        
        let yAxis = chartView.yAxis
        yAxis.labelTextColor = .clear
        yAxis.labelCount = 4
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 7
        yAxis.drawLabelsEnabled = false
        
        chartView.legend.setCustom(entries: [])
        
        self.view.addSubview(chartView)
        
        chartView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        chartView.heightAnchor.constraint(lessThanOrEqualTo: chartView.widthAnchor).isActive = true
        chartView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        chartView.centerYAnchor.constraint(equalTo: self.view.centerYAnchor).isActive = true
        
        var entries = [ChartDataEntry]()
        entries.append(RadarChartDataEntry(value: 9))
        entries.append(RadarChartDataEntry(value: 5))
        entries.append(RadarChartDataEntry(value: 4))
        entries.append(RadarChartDataEntry(value: 6))
        entries.append(RadarChartDataEntry(value: 5))
        entries.append(RadarChartDataEntry(value: 1))
        entries.append(RadarChartDataEntry(value: 8))
        entries.append(RadarChartDataEntry(value: 10))
        entries.append(RadarChartDataEntry(value: 8))
        entries.append(RadarChartDataEntry(value: 10))
        let dataSet = RadarChartDataSet(values: entries, label: nil)
        dataSet.setColor(#colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1))
        dataSet.fillColor = #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
        dataSet.drawFilledEnabled = true
        dataSet.fillAlpha = 0.4
        
        
        let data = RadarChartData(dataSet: dataSet)
        data.setDrawValues(false)
        chartView.data = data
    }
}

extension RadarChartTestViewController: ChartViewDelegate {
    
}

extension RadarChartTestViewController: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        return ["aaaaaaaaa","bbbbbbbbb","vvvvvvvvvv", "ccccccc", "dddddddd"][Int(value) % 5]
    }
}
