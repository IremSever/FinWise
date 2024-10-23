//
//  StockTimeSeriesViewModel.swift
//  FinWise
//
//  Created by IREM SEVER on 23.10.2024.
//

import Foundation

class StockTimeSeriesViewModel {
    private var stockTimeSeriesWebservice = StockTimeSeriesWebservice()
    var stockTimeSeries: [TimeSery] = []
    
    func fetchStockTimeSeriesData(completion: @escaping () -> ()) {
        stockTimeSeriesWebservice.fetchStockTimeSeries { [weak self] result in
            switch result {
            case .success(let stockTimeSeriesModel):
                if stockTimeSeriesModel.data.timeSeries.isEmpty {
                    print("No time series data available")
                } else {
                    self?.stockTimeSeries = stockTimeSeriesModel.data.timeSeries
                    completion()
                }
                
            case .failure(let error):
                print("Error fetching time series: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return stockTimeSeries.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> TimeSery {
        guard indexPath.row < stockTimeSeries.count else {
            fatalError("Index out of range for stockTimeSeries")
        }
        return stockTimeSeries[indexPath.row]
    }
}

