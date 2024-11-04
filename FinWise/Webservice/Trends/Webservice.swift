//
//  Webservice.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//
import Foundation

class Webservice {
    
    func fetchTrends(completion: @escaping (Result<FinWiseModel, Error>) -> Void) {
        let urlString = "https://real-time-finance-data.p.rapidapi.com/market-trends?trend_type=MARKET_INDEXES&country=us&language=en"
        
        guard let url = URL(string: urlString) else {
            print("Invalid URL")
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        request.addValue("5de7d22abcmsh46c0760033e149fp1bb52ejsnc494768bc4fd", forHTTPHeaderField: "x-rapidapi-key")
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
            
            //print("Response status code: \(httpResponse.statusCode)")
            
            guard let data = data else {
                print("No data returned")
                return
            }
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("Raw JSON data: \(jsonString)")
            }
            
            do {
                let decoder = JSONDecoder()
                let finWiseModel = try decoder.decode(FinWiseModel.self, from: data)
                
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
