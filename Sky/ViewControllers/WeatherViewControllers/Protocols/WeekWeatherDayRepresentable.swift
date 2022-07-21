//
//  WeekWeatherDayRepresentable.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import UIKit

protocol WeekWeatherDayRepresentable {
    var week: String { get }
    var date: String { get }
    var temperature: String { get }
    var weatherIcon: UIImage? { get }
    var humidity: String { get }
}
