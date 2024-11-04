//
//  NewsDetailViewModel.swift
//  FinWise
//
//  Created by İrem Sever on 1.11.2024.
//

import Foundation

class NewsDetailViewModel {
    var newsList: [NewsDetailModel] = []
    
    func fetchNewsDetailData(completion: @escaping () -> ()) {
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
                          let thumbnailDict = data["thumbnail"] as? [String: Any],
                          let resolutions = thumbnailDict["resolutions"] as? [[String: Any]],
                          let firstResolution = resolutions.first,
                          let thumbnailURL = firstResolution["url"] as? String,
                          let width = firstResolution["width"] as? Int else {
                        return nil
                    }
                    
                    let height = firstResolution["height"] as? Int
                    let tag = firstResolution["tag"] as? String
                    
                    let thumbnail = Thumbnail(url: thumbnailURL, width: width, height: height, tag: tag)
                    return NewsDetailModel(uuid: uuid, title: title, publisher: publisher, link: link, providerPublishTime: providerPublishTime, type: type, thumbnail: thumbnail)
                }
            }
        } catch {
            print("Error loading JSON: \(error)")
        }
    }
    
    func numberOfRowsInSection(section: Int) -> Int {
        return 1
    }
    func cellForRowAt(indexPath: IndexPath) -> [NewsDetailModel] {
        return newsList
    }
    func getNewsModel(for index: Int) -> NewsDetailModel? {
        guard index >= 0 && index < newsList.count else { return nil }
        return newsList[index]
    }
}
