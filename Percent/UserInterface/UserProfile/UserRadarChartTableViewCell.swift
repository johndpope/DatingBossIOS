//
//  UserRadarChartTableViewCell.swift
//  Percent
//
//  Created by Jun-kyu Jeon on 18/01/2019.
//  Copyright © 2019 연애대장. All rights reserved.
//

import UIKit

import Charts

class ChartValueData: BaseData {
    var code: String? {
        return rawData["code"] as? String
    }
    
    var value: Double {
        return rawData["graph_value"] as? Double ?? 0
    }
    
    var name: String? {
        return rawData["code_name"] as? String
    }
    
    var mem_idx: Int? {
        return rawData["mem_idx"] as? Int
    }
}

class UserRadarChartTableViewCell: UITableViewCell {
    let labelTitle = UILabel()
    private let chartView = RadarChartView()
    
    var showLegend = false
    
    var data: [ChartValueData]?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.selectionStyle = .none
        
        let seperator = UIView()
        seperator.backgroundColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        seperator.translatesAutoresizingMaskIntoConstraints = false
        self.contentView.addSubview(seperator)
        
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.backgroundColor = #colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0)
        labelTitle.textColor = #colorLiteral(red: 0.2901960784, green: 0.2901960784, blue: 0.2901960784, alpha: 1)
        labelTitle.textAlignment = .center
        labelTitle.font = UIFont.systemFont(ofSize: 16 * QUtils.optimizeRatio(), weight: .bold)
        self.contentView.addSubview(labelTitle)
        
        labelTitle.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        labelTitle.topAnchor.constraint(equalTo: self.contentView.topAnchor).isActive = true
        labelTitle.widthAnchor.constraint(equalToConstant: 88).isActive = true
        labelTitle.heightAnchor.constraint(equalToConstant: 46 * QUtils.optimizeRatio()).isActive = true
        
        seperator.centerYAnchor.constraint(equalTo: labelTitle.centerYAnchor).isActive = true
        seperator.leadingAnchor.constraint(equalTo: self.contentView.leadingAnchor, constant: 16 * QUtils.optimizeRatio()).isActive = true
        seperator.trailingAnchor.constraint(equalTo: self.contentView.trailingAnchor, constant: -16 * QUtils.optimizeRatio()).isActive = true
        seperator.heightAnchor.constraint(equalToConstant: 1).isActive = true
        
        chartView.translatesAutoresizingMaskIntoConstraints = false
        chartView.delegate = self
        chartView.webColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        chartView.innerWebColor = #colorLiteral(red: 0.8, green: 0.8, blue: 0.8, alpha: 1)
        chartView.isUserInteractionEnabled = false
        chartView.chartDescription?.enabled = false
        chartView.skipWebLineCount = 0
        
        let xAxis = chartView.xAxis
        xAxis.forceLabelsEnabled = false
        xAxis.xOffset = 0
        xAxis.yOffset = 0
        xAxis.valueFormatter = self
        
        let yAxis = chartView.yAxis
        yAxis.labelTextColor = .clear
        yAxis.labelCount = 4
        yAxis.axisMinimum = 0
        yAxis.axisMaximum = 3
        yAxis.drawLabelsEnabled = false
        
        chartView.legend.setCustom(entries: [])
        
        self.contentView.addSubview(chartView)
        
        chartView.widthAnchor.constraint(equalToConstant: UIScreen.main.bounds.size.width * 0.8).isActive = true
        chartView.heightAnchor.constraint(equalTo: chartView.widthAnchor).isActive = true
        chartView.centerXAnchor.constraint(equalTo: self.contentView.centerXAnchor).isActive = true
        chartView.topAnchor.constraint(equalTo: labelTitle.bottomAnchor).isActive = true
        chartView.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError()
    }
    
    func reloadData() {
        var myEntries = [ChartDataEntry](), oppEntries = [ChartDataEntry]()
        
        let dataArray = data ?? []
        
        for i in 0 ..< dataArray.count {
            let item = dataArray[i]
            guard let mem_idx = item.mem_idx else { continue }
            
            let newEntry = RadarChartDataEntry(value: item.value)
            
            if mem_idx == MyData.shared.mem_idx {
                myEntries.append(newEntry)
            } else {
                oppEntries.append(newEntry)
            }
        }
        
        let myDataSet = RadarChartDataSet(values: myEntries, label: nil)
        myDataSet.setColor(#colorLiteral(red: 0, green: 0, blue: 1, alpha: 1))
        myDataSet.fillColor = #colorLiteral(red: 0, green: 0, blue: 1, alpha: 1)
        myDataSet.drawFilledEnabled = true
        myDataSet.fillAlpha = 0.4
        
        let oppDataSet = RadarChartDataSet(values: oppEntries, label: nil)
        oppDataSet.setColor(#colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1))
        oppDataSet.fillColor = #colorLiteral(red: 0.9411764706, green: 0.1921568627, blue: 0.2549019608, alpha: 1)
        oppDataSet.drawFilledEnabled = true
        oppDataSet.fillAlpha = 0.4
        
        let cData = RadarChartData(dataSets: [myDataSet, oppDataSet])
        cData.setDrawValues(false)
        chartView.data = cData
    }
}

extension UserRadarChartTableViewCell: ChartViewDelegate {
    
}

extension UserRadarChartTableViewCell: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard data != nil, index < data!.count else { return "" }
        return data![index].name ?? ""
    }
}
