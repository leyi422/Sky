//
//  CurrentLocationViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/8/4.
//

import Foundation

struct CurrentLocationViewModel {
    var location: Location
    
    static let empty = CurrentLocationViewModel(location: Location.empty)
    
    static let invalid = CurrentLocationViewModel(location: Location.invalid)
    
    var city: String {
        return location.name
    }
    
    var isEmpty: Bool {
        return location == Location.empty
    }
    
    var isInvalid: Bool {
        return location == Location.invalid
    }
}
