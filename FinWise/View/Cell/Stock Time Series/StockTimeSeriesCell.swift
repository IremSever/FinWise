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

    func configure(with timeSeriesData: [TimeSeries]) {
        var entries = [ChartDataEntry]()
        
        let maxPoints = 10
        let limitedData = Array(timeSeriesData.prefix(maxPoints))
        
        for (index, dataPoint) in limitedData.enumerated() {
            let entry = ChartDataEntry(x: Double(index), y: dataPoint.price)
            entries.append(entry)
        }
        
        let set = LineChartDataSet(entries: entries, label: "NASDAQ Price")
        set.colors = [UIColor.black]
        set.circleColors = [UIColor.black]
        set.circleRadius = 3
        set.drawFilledEnabled = true

        let gradientColors = [UIColor.orange.cgColor, UIColor.clear.cgColor] as CFArray
        let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors: gradientColors, locations: [0.0, 1.0])!
       
        set.fillColor = UIColor(red: 237/255, green: 248/255, blue: 95/255, alpha: 1.0)
        
        let data = LineChartData(dataSet: set)
        viewChart.data = data
        
        viewChart.animate(xAxisDuration: 1.5)
    }
}
