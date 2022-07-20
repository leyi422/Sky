//
//  CurrentWeatherViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/12.
//

import UIKit

struct CurrentWeatherViewModel {
    var isLocationReady = false
    var isWeatherReady = false
    
    var isUpdateReady: Bool {
        return isLocationReady && isWeatherReady
    }
    
    var location: Location! {
        didSet {
            isLocationReady = location != nil
        }
    }
    
    var weather: WeatherData! {
        didSet {
            isWeatherReady = weather != nil
        }
    }
    
    var city: String {
        return location.name
    }
    
    var temperature: String {
        return String(format: "%.1f ℃", weather.currently.temperature.toCelcius())
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weather.currently.humidity * 100)
    }
    
    var summary: String {
        return weather.currently.summary
    }
    
    var date: String {
        let formatter = DateFormatter()
        formatter.dateFormat = "E, dd MMMM"
        return formatter.string(from: weather.currently.time)
    }
    
    var weatherIcon: UIImage {
        return UIImage.weatherIcon(of: weather.currently.icon)!
    }
}