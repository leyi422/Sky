//
//  SettingsContent.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit

protocol SettingsRepresentable {
    var labelText: String { get }
    var accessory: UITableViewCell.AccessoryType { get }
}
