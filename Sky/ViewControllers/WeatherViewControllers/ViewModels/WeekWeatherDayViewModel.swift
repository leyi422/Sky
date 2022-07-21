//
//  WeekWeatherDayViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit

struct WeekWeatherDayViewModel {
    let weatherData: ForecastData
    
    private let dateDormatter = DateFormatter()
    
    var week: String {
        dateDormatter.dateFormat = "EEEE"
        return dateDormatter.string(from: weatherData.time)
    }
    
    var date: String {
        dateDormatter.dateFormat = "MMMM d"
        return dateDormatter.string(from: weatherData.time)
    }
    
    var temperature: String {
        let min = format(temperature: weatherData.temperatureLow)
        let max = format(temperature: weatherData.temperatureHigh)
        return "\(min) - \(max)"
    }
    
    var weatherIcon: UIImage? {
        return UIImage.weatherIcon(of: weatherData.icon)
    }
    
    var humidity: String {
        return String(format: "%.1f %%", weatherData.humidity * 100)
    }
    
    private func format(temperature: Double) -> String {
        switch UserDefaults.temperatureMode() {
        case .fahrenheit:
            return String(format: "%.1f °F", temperature)
        case .celsius:
            return String(format: "%.1f ℃", temperature.toCelcius())
        }
    }
}

extension WeekWeatherDayViewModel: WeekWeatherDayRepresentable {}
