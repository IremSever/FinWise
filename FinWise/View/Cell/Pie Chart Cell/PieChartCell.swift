//
//  PieChartCell.swift
//  FinWise
//
//  Created by İrem Sever on 4.11.2024.
//

import UIKit
import DGCharts
class PieChartCell: UICollectionViewCell, ChartViewDelegate {
    var pieChart = PieChartView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupChart()
    }
    
    private func setupChart() {
        pieChart.delegate = self
        contentView.addSubview(pieChart)
        
        pieChart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            pieChart.topAnchor.constraint(equalTo: contentView.topAnchor),
            pieChart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            pieChart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            pieChart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        pieChart.frame = CGRect(x: 0, y: 0,
                                width: contentView.frame.size.width,
                                height: contentView.frame.size.height)
        pieChart.center = contentView.center
    }
    
    func configure(with timeSeriesData: [TimeSeries]) {
        var entries = [ChartDataEntry]()
        for x in 0..<10 {
            entries.append(ChartDataEntry(x: Double(x), y: Double(x))
        }
        
        let set = PieChartDataSet(entries: entries)
        set.colors = ChartColorTemplates.pastel()
        let data = PieChartData(dataSet: set)
        pieChart.data = data
    }
}
