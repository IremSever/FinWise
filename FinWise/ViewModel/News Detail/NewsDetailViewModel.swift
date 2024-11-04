//
//  NewsDetailViewModel.swift
//  FinWise
//
//  Created by İrem Sever on 1.11.2024.
//

import Foundation

class NewsDetailViewModel {
    private var newsList: [NewsDetailModel] = []
    
    init() {
        loadNewsFromJSON()
    }
    
    private func loadNewsFromJSON() {
        guard let path = Bundle.main.path(forResource: "newsdetail", ofType: "json") else {
            print("JSON file not found.")
            return
        }
        
        do {
            let data = try Data(contentsOf: URL(fileURLWithPath: path))
            if let jsonArray = try JSONSerialization.jsonObject(with: data, options: []) as? [[String: Any]] {
                newsList = jsonArray.compactMap { data in
                    guard let uuid = data["uuid"] as? String,
                          let title = data["title"] as? String,
                          let publisher = data["publisher"] as? String,
                          let link = data["link"] as? String,
                          let providerPublishTime = data["providerPublishTime"] as? Int,
                          let type = data["type"] as? String,
                          let thumbnailResolutions = data["thumbnail"] as? [String: Any],
                          let resolutions = thumbnailResolutions["resolutions"] as? [[String: Any]],
                          let thumbnailURL = resolutions.first?["url"] as? String else {
                        return nil
                    }
                    return NewsDetailModel(uuid: uuid, title: title, publisher: publisher, link: link, providerPublishTime: providerPublishTime, type: type, thumbnailURL: thumbnailURL)
                }
            }
        } catch {
            print("Error loading JSON: \(error)")
        }
    }
    
    func getLink(for index: Int) -> String? {
        guard index >= 0 && index < newsList.count else { return nil }
        return newsList[index].link
    }
}
