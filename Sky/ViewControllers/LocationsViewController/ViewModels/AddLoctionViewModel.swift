//
//  AddLoctionViewModel.swift
//  Sky
//
//  Created by 张家玮 on 2022/8/4.
//

import CoreLocation

class AddLoctionViewModel {
    
    var queryText: String = "" {
        didSet {
            geocode(address: queryText)
        }
    }
    
    private func geocode(address: String?) {
        guard let address = address else {
            locations = []
            return
        }
        
        isQuerying = true
        
        geocoder.geocodeAddressString(address) { [weak self] placemarks, error in
            self?.processResponse(with: placemarks, error: error)
        }
    }
    
    private func processResponse(with placemarks: [CLPlacemark]?, error: Error?) {
        isQuerying = false
        var locs: [Location] = []
        
        if let error = error {
            print("Cannot handle Geocode Address! \(error)")
        }
        else if let results = placemarks {
            locs = results.compactMap {
                guard let name = $0.name else { return nil }
                guard let location = $0.location else { return nil }
                
                return Location(name: name, latitude: location.coordinate.latitude, longitude: location.coordinate.longitude)
            }
            
            locations = locs
        }
    }
    
    private var isQuerying = false {
        didSet {
            queryingStatusDidChange?(isQuerying)
        }
    }
    
    private var locations: [Location] = [] {
        didSet {
            locationsDidChange?(locations)
        }
    }
    
    private lazy var geocoder = CLGeocoder()
    
    var queryingStatusDidChange: ((Bool) -> Void)?
    var locationsDidChange: (([Location]) -> Void)?
    
    var numberOfLocations: Int {
        return locations.count
    }
    
    var hasLocationsResult: Bool {
        return numberOfLocations > 0
    }
    
    func location(at index: Int) -> Location? {
        guard index < numberOfLocations else {
            return nil
        }
        
        return locations[index]
    }
    
    func locationViewModel(at index: Int) -> LocationsViewModel? {
        guard let location = location(at: index) else {
            return nil
        }
        
        return LocationsViewModel(location: location.location, locationText: location.name)
    }
    
}
