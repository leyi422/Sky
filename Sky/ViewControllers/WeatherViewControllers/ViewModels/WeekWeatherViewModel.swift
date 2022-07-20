//
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/20.
//

import Foundation
import UIKit

struct WeekWeatherViewModel {
    let weatherData: [ForecastData]
    
    private let dateDormatter = DateFormatter()
    
    func week(for index: Int) -> String {
        dateDormatter.dateFormat = "EEEE"
        return dateDormatter.string(from: weatherData[index].time)
    }
    
    func date(for index: Int) -> String {
        dateDormatter.dateFormat = "MMMM d"
        return dateDormatter.string(from: weatherData[index].time)
    }
    
    func temperature(for index: Int) -> String {
        let min = format(temperature: weatherData[index].temperatureLow)
        let max = format(temperature: weatherData[index].temperatureHigh)
        return "\(min) - \(max)"
    }
    
    func weatherIcon(for index: Int) -> UIImage? {
        return UIImage.weatherIcon(of: weatherData[index].icon)
    }
    
    func humidity(for index: Int) -> String {
        return String(format: "%.1f %%", weatherData[index].humidity * 100)
    }
    
    var numberOfSections: Int {
        return 1
    }
    
    var numberOfDays: Int {
        return weatherData.count
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
