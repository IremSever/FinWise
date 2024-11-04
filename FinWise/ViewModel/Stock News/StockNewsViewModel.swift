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
    
    func numberOfItemsForCase3() -> Int {
           return min(stockNews.count, 6)
       }
       
       func numberOfItemsForCase5() -> Int {
           return min(max(stockNews.count - 6, 0), 4)
       }
       
       func cellForRowAt(indexPath: IndexPath) -> News {
           let index = indexPath.section == 3 ? indexPath.row : indexPath.row + 6
           return stockNews[index]
       }
}
