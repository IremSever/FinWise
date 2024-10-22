//
//  StockNewsModel.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation
import Foundation

struct StockNewsModel: Codable {
    let status: String
    let request_id: String
    let data: StockNewsData
}

struct StockNewsData: Codable {
    let trends: [StockNews]
    let news: [StockNewsArticle]
}

struct StockNewsArticle: Codable {
    let articleTitle: String
    let articleURL: String
    let articlePhotoURL: String
    let source: String
    let postTimeUTC: String
    let stocksInNews: [StockNews]
    
    enum CodingKeys: String, CodingKey {
        case articleTitle = "article_title"
        case articleURL = "article_url"
        case articlePhotoURL = "article_photo_url"
        case source
        case postTimeUTC = "post_time_utc"
        case stocksInNews = "stocks_in_news"
    }
}

struct StockNews: Codable {
    let symbol: String
    let type: String
    let name: String
    let price: Double
    let change: Double
    let changePercent: Double
    let previousClose: Double
    let lastUpdateUTC: String
    let timezone: String
    let utcOffsetSec: Int
    let googleMid: String

    enum CodingKeys: String, CodingKey {
        case symbol
        case type
        case name
        case price
        case change
        case changePercent = "change_percent"
        case previousClose = "previous_close"
        case lastUpdateUTC = "last_update_utc"
        case timezone
        case utcOffsetSec = "utc_offset_sec"
        case googleMid = "google_mid"
    }
}

