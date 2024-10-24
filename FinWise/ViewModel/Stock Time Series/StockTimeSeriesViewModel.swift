//
//  StockTimeSeriesViewModel.swift
//  FinWise
//
//  Created by IREM SEVER on 23.10.2024.
//

import Foundation

import Foundation

class StockTimeSeriesViewModel {
    private var stockTimeSeriesWebservice = StockTimeSeriesWebservice()
    var timeSeriesDataClass: TimeSeriesDataClass?
    
    var stockTimeSeries: [TimeSeries] {
        return timeSeriesDataClass?.timeSeries?.values.map { $0 } ?? []
    }
    
    func fetchStockTimeSeriesData(completion: @escaping () -> ()) {
        stockTimeSeriesWebservice.fetchStockTimeSeries { [weak self] result in
            switch result {
            case .success(let stockTimeSeriesModel):
                self?.timeSeriesDataClass = stockTimeSeriesModel.data
                completion()
                
            case .failure(let error):
                print("Error fetching time series: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    
    func cellForRowAt(indexPath: IndexPath) -> [TimeSeries] {
        return stockTimeSeries
    }
    
    func stockSymbol() -> String {
        return timeSeriesDataClass?.symbol ?? ""
    }
    
    func currentPrice() -> Double {
        return timeSeriesDataClass?.price ?? 0.0
    }
    
    func changePercent() -> Double {
        return timeSeriesDataClass?.changePercent ?? 0.0
    }
    
    func lastUpdateUTC() -> String {
        return timeSeriesDataClass?.lastUpdateUTC ?? ""
    }
}
