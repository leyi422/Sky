//
//  SettingsDateViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit

struct SettingsDateViewModel {
    let dateMode: DateMode
    
    var labelText: String {
        return dateMode == .text ? "Fri, 01 December" : "F, 12/01"
    }
    
    var accessory: UITableViewCell.AccessoryType {
        return UserDefaults.dateMode() == dateMode ? .checkmark : .none
    }
}
