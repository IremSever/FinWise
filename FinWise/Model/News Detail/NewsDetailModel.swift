//
//  NewsDetailModel.swift
//  FinWise
//
//  Created by İrem Sever on 31.10.2024.
//

import Foundation

struct NewsDetailModel {
    let uuid: String?
    let title: String?
    let publisher: String?
    let link: String
    let providerPublishTime: Int?
    let type: String?
    let thumbnail: Thumbnail?
}

struct Thumbnail {
    let url: String?
    let width: Int?
    let height: Int?
    let tag: String?
}
