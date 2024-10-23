//
//  StockNewsViewModel.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation

class StockNewsViewModel {
    private var stockNewsWebservice = StockNewsWebservice()
    var stockNews: [News] = []
    
    func fetchStockNewsData(completion: @escaping () -> ()) {
        stockNewsWebservice.fetchStockNews { [weak self] result in
            switch result {
            case .success(let stockNewsModel):
                self?.stockNews = stockNewsModel.data.news
                completion()
                
            case .failure(let error):
                print("Error fetching stock news: \(error.localizedDescription)")
            }
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return stockNews.count
    }
    
    func cellForRowAt(indexPath: IndexPath) -> News {
        return stockNews[indexPath.row]
    }
}
