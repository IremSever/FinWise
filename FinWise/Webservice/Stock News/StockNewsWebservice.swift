//
//  StockNewsWebservice.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation

class StockNewsWebservice {
    
    func fetchTrends(completion: @escaping (Result<StockNewsModel, Error>) -> Void) {
        let urlString = "https://real-time-finance-data.p.rapidapi.com/stock-time-series?symbol=AAPL%3ANASDAQ&period=1D&language=en"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("8058a9f591msh08776cbbf802218p1f3240jsn803869f6f26a", forHTTPHeaderField: "x-rapidapi-key")
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
                let finWiseModel = try decoder.decode(StockNewsModel.self, from: data)
                
                DispatchQueue.main.async {
                    completion(.success(finWiseModel))
                }
            } catch let error {
                print("JSON parsing error: \(error.localizedDescription)")
                completion(.failure(error))
            }
        }.resume()
    }
}
