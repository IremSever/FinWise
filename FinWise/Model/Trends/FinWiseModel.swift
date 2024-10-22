//
//  FinWiseModel.swift
//  FinWise
//
//  Created by IREM SEVER on 22.10.2024.
//

import Foundation

struct FinWiseModel: Codable {
    let status: String
    let request_id: String
    let data: MarketTrendsData
}

struct MarketTrendsData: Codable {
    let trends: [MarketTrend]
}

struct MarketTrend: Codable {
    let symbol: String
    let type: String
    let name: String
    let price: Double
    let change: Double
    let change_percent: Double
    let previous_close: Double
    let last_update_utc: String
    let exchange_open: String
    let exchange_close: String
    let timezone: String
    let utc_offset_sec: Int
    let google_mid: String
}

