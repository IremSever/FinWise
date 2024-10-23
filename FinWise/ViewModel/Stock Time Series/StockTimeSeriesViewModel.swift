//
//  StockTimeSeriesViewModel.swift
//  FinWise
//
//  Created by IREM SEVER on 23.10.2024.
//

import Foundation

class StockTimeSeriesViewModel {
    private var stockTimeSeriesWebservice = StockTimeSeriesWebservice()
    var stockTimeSeries: [TimeSeries] = []
    
    func fetchStockTimeSeriesData(completion: @escaping () -> ()) {
        stockTimeSeriesWebservice.fetchStockTimeSeries { [weak self] result in
            switch result {
            case .success(let stockTimeSeriesModel):
                if let timeSeriesDict = stockTimeSeriesModel.data.timeSeries {
                    self?.stockTimeSeries = Array(timeSeriesDict.values)
                    completion()
                } else {
                    print("No time series data available")
                }
                
            case .failure(let error):
                print("Error fetching time series: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return stockTimeSeries.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TimeSeries {
        guard indexPath.row < stockTimeSeries.count else {
            fatalError("Index out of range for stockTimeSeries")
        }
        return stockTimeSeries[indexPath.row]
    }
}

