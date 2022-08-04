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
    let daily: WeekWeatherData
    
    struct CurrentWeather: Codable {
        let time: Date
        let summary: String
        let icon: String
        let temperature: Double
        let humidity: Double
    }
    
    struct WeekWeatherData: Codable {
        let data: [ForecastData]
    }
    
    static let empty = WeatherData(latitude: 0, longitude: 0, currently: CurrentWeather(time: Date(), summary: "", icon: "", temperature: 0, humidity: 0), daily: WeekWeatherData(data: []))
}

extension WeatherData.CurrentWeather: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.time == rhs.time && lhs.summary == rhs.summary && lhs.icon == rhs.icon && lhs.temperature == rhs.temperature && lhs.humidity == rhs.humidity
    }
}

extension WeatherData.WeekWeatherData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.data == rhs.data
    }
}

extension WeatherData: Equatable {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return lhs.latitude == rhs.latitude && lhs.longitude == rhs.longitude && lhs.currently == rhs.currently
    }
}
