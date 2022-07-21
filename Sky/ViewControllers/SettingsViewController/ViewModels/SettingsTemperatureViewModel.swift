//
//  SettingsTemperatureViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit

struct SettingsTemperatureViewModel {
    let temperatureMode: TemperatureMode
    
    var labelText: String {
        return temperatureMode == .celsius ? "Celcius" : "Fahrenheit"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        return UserDefaults.temperatureMode() == temperatureMode ? .checkmark : .none
    }
}

extension SettingsTemperatureViewModel: SettingsRepresentable {}
