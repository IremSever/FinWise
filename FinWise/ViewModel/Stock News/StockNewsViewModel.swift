//
//  StockNewsViewModel.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation

class StockNewsViewModel {
    private var webservice = StockNewsWebservice()
    var marketTrends: [StockNews] = []
    
    func fetchMarketTrendsData(completion: @escaping () -> ()) {
        webservice.fetchTrends { [weak self] result in
            switch result {
            case .success(let finWiseModel):
                self?.marketTrends = finWiseModel.data.trends
                completion()
                
            case .failure(let error):
                print("Error fetching market trends: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return marketTrends.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> StockNews {
        return marketTrends[indexPath.row]
    }
}
