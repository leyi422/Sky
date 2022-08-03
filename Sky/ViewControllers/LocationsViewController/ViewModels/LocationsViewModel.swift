//
//  LocationsViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/21.
//

import Foundation
import CoreLocation

struct LocationsViewModel {
    let location: CLLocation?
    let locationText: String?
}

extension LocationsViewModel: LocationRepresentable {
    var labelText: String {
        if let locationText = locationText {
            return locationText
        }
        else if let location = location {
            return location.toString
        }
        
        return "UnKnown position"
    }
}
