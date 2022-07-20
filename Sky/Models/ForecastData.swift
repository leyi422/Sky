//
//  ForecastData.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/20.
//

import Foundation

struct ForecastData: Codable {
    let time: Date
    let temperatureLow: Double
    let temperatureHigh: Double
    let icon: String
    let humidity: Double
}

extension ForecastData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.time == rhs.time && lhs.temperatureLow == rhs.temperatureLow && lhs.temperatureHigh == rhs.temperatureHigh && lhs.icon == rhs.icon && lhs.humidity == rhs.humidity
    }
}
