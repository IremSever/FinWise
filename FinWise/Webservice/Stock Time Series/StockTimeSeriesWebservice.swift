//
//  StockTimeSeriesWebservice.swift
//  FinWise
//
//  Created by IREM SEVER on 23.10.2024.
//

import Foundation

class StockTimeSeriesWebservice {
    
    func fetchStockTimeSeries(completion: @escaping (Result<StockTimeSeriesModel, Error>) -> Void) {
        let urlString = "https://real-time-finance-data.p.rapidapi.com/stock-time-series?symbol=AAPL%3ANASDAQ&period=1D&language=en"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("9cd3c3e097msh5344285cb3b108ep10f0bajsnc47c37ffad6c", forHTTPHeaderField: "x-rapidapi-key")
        request.addValue("real-time-finance-data.p.rapidapi.com", forHTTPHeaderField: "x-rapidapi-host")
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            if let error = error {
//                print("DataTask error: \(error.localizedDescription)")
                completion(.failure(error))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse else {
                print("Invalid response")
                return
            }
            
//            print("Response status code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let stockTimeSeriesModel = try decoder.decode(StockTimeSeriesModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(stockTimeSeriesModel))
                }
            } catch let error {
                print("Time Series JSON parsing error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}

