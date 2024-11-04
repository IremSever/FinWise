//
//  BarChartCell.swift
//  FinWise
//
//  Created by İrem Sever on 4.11.2024.
//

import UIKit
import DGCharts

class BarChartCell: UICollectionViewCell, ChartViewDelegate {
    var barChart = BarChartView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupChart()
    }
    
    private func setupChart() {
        barChart.delegate = self
        contentView.addSubview(barChart)
        
        barChart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            barChart.topAnchor.constraint(equalTo: contentView.topAnchor),
            barChart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            barChart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            barChart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with timeSeriesData: [TimeSeries]) {
        barChart.frame = CGRect(x: 0, y: 0,
                                width: contentView.frame.size.width,
                                height: contentView.frame.size.height)
        
        var entries = [BarChartDataEntry]()
        for x in 0..<10 {
            entries.append(BarChartDataEntry(x: Double(x), y: Double(x)))
        }
        
        let set = BarChartDataSet(entries: entries)
        set.colors = [
            UIColor(red: 10/255, green: 10/255, blue: 12/255, alpha: 1),
            UIColor(red: 237/255, green: 248/255, blue: 95/255, alpha: 1),
            UIColor(red: 215/255, green: 215/255, blue: 215/255, alpha: 1),
            UIColor(red: 201/255, green: 188/255, blue: 246/255, alpha: 1)
        ]
        
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
}
