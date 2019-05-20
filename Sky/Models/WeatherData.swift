//
//  WeatherData.swift
//  Sky
//
//  Created by Jiawei Zhang on 2019/5/20.
//  Copyright © 2019 ZhangJiawei. All rights reserved.
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
