//
//  WeatherData.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import Foundation

struct WeatherData: Codable {
    let latitude: Double
    let longitude: Double
    let currently: CurrentWeather
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}

extension WeatherData.CurrentWeather: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.time == rhs.time && lhs.summary == rhs.summary && lhs.icon == rhs.icon && lhs.temperature == rhs.temperature && lhs.humidity == rhs.humidity
    }
}

extension WeatherData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.currently == rhs.currently
    }
}
