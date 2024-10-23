//
//  StockTimeSeriesModel.swift
//  FinWise
//
//  Created by IREM SEVER on 23.10.2024.
//

import Foundation

// MARK: - StockTimeSeriesModel
struct StockTimeSeriesModel: Codable {
    let status, requestID: String
    let data: TimeSeriesDataClass

    enum CodingKeys: String, CodingKey {
        case status
        case requestID = "request_id"
        case data
    }
}

// MARK: - DataClass
struct TimeSeriesDataClass: Codable {
    let symbol, type: String?
    let price, previousClose, change, changePercent: Double?
    let preOrPostMarket, preOrPostMarketChange, preOrPostMarketChangePercent: Double?
    let lastUpdateUTC: String?
    let timeSeries: [String: TimeSeries]?
    let utcOffsetSEC, intervalSEC: Int?
    let period: String?

    enum CodingKeys: String, CodingKey {
        case symbol, type, price
        case previousClose = "previous_close"
        case change
        case changePercent = "change_percent"
        case preOrPostMarket = "pre_or_post_market"
        case preOrPostMarketChange = "pre_or_post_market_change"
        case preOrPostMarketChangePercent = "pre_or_post_market_change_percent"
        case lastUpdateUTC = "last_update_utc"
        case timeSeries = "time_series"
        case utcOffsetSEC = "utc_offset_sec"
        case intervalSEC = "interval_sec"
        case period
    }
}

// MARK: - TimeSery
struct TimeSeries: Codable {
    let price, change, changePercent: Double
    let volume: Int

    enum CodingKeys: String, CodingKey {
        case price, change
        case changePercent = "change_percent"
        case volume
    }
}

