//
//  StockNewsWebservice.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation

class StockNewsWebservice {
    
    func fetchStockNews(completion: @escaping (Result<StockNewsModel, Error>) -> Void) {
        let urlString = "https://real-time-finance-data.p.rapidapi.com/stock-news?symbol=AAPL%3ANASDAQ&language=en"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("840001740dmshe2a3aae55ce8f18p13bedbjsn3bcbf76a003c", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("real-time-finance-data.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
                print("DataTask error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
            print("Response status code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let stockNewsModel = try decoder.decode(StockNewsModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(stockNewsModel))
                }
            } catch let error {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
