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
        set.colors = ChartColorTemplates.joyful()
        let data = BarChartData(dataSet: set)
        barChart.data = data
    }
}
