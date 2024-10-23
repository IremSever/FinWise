//
//  StockTimeSeriesCell.swift
//  FinWise
//
//  Created by IREM SEVER on 23.10.2024.
//

import UIKit
import DGCharts

class StockTimeSeriesCell: UICollectionViewCell, ChartViewDelegate {
    
    var viewChart = LineChartView()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        setupChart()
    }

    private func setupChart() {
        viewChart.delegate = self
        contentView.addSubview(viewChart)
        
        viewChart.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewChart.topAnchor.constraint(equalTo: contentView.topAnchor),
            viewChart.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            viewChart.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            viewChart.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
        ])
    }
    
    func configure(with timeSeriesData: [TimeSery]) {
        guard let dataPoint = timeSeriesData.first else { return }
        
        var entries = [ChartDataEntry]()
        let entry = ChartDataEntry(x: 0, y: dataPoint.price)
        entries.append(entry)
        
        let set = LineChartDataSet(entries: entries, label: "Stock Prices")
        set.colors = ChartColorTemplates.material()
        set.circleColors = [UIColor.red]
        set.valueColors = [.black]
        
        let data = LineChartData(dataSet: set)
        viewChart.data = data
        
        // Animasyon ve diğer ayarlar
        viewChart.animate(xAxisDuration: 1.5)
    }

}
