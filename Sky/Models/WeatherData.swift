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
        let summary: Double
        let icon: String
        let temperature: Double
        let humidity: Double
    }
}
