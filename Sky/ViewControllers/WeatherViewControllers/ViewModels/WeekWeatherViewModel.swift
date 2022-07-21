//
//  WeekWeatherViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/20.
//

import Foundation

struct WeekWeatherViewModel {
    let weatherData: [ForecastData]
    
    func viewModel(for index: Int) -> WeekWeatherDayViewModel {
        return WeekWeatherDayViewModel(weatherData: weatherData[index])
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
