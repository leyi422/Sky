//
//  CLLocation.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import CoreLocation

extension CLLocation {
    var toString: String {
        let latitude = String(format: "%.3f", coordinate.latitude)
        let longitude = String(format: "%.3f", coordinate.longitude)
        
        return "\(latitude), \(longitude)"
    }
}
