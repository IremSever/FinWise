//
//  StockNewsModel.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation

struct StockNewsModel: Codable {
    let status, requestID: String
    let data: DataClass

    enum CodingKeys: String, CodingKey {
        case status
        case requestID = "request_id"
        case data
    }
}

struct DataClass: Codable {
    let symbol, type: String
    let news: [News]
}

struct News: Codable {
    let articleTitle: String
    let articleURL: String
    let articlePhotoURL: String
    let source, postTimeUTC: String

    enum CodingKeys: String, CodingKey {
        case articleTitle = "article_title"
        case articleURL = "article_url"
        case articlePhotoURL = "article_photo_url"
        case source
        case postTimeUTC = "post_time_utc"
    }
}
