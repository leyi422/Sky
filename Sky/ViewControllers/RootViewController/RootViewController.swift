//
//  RootViewController.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import UIKit
import CoreLocation

class RootViewController: UIViewController {
    
    var currentWeatherController: CurrentWeatherViewController!
    private let segueCurrentWeather = "SegueCurrentWeather"
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError()
            }
            
            currentWeatherController = destination
        default:
            break
        }
    }
    
    
    private var currentLoaction: CLLocation? {
        didSet {
            fetchCity()
            fetchWeather()
        }
    }
    
    private func fetchWeather() {
        guard let currentLoaction = currentLoaction else {
            return
        }
        
        let lat = currentLoaction.coordinate.latitude
        let lon = currentLoaction.coordinate.longitude
        
        WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon) { response, error in
            if let error = error {
                dump(error)
            }
            else if let response = response {
                self.currentWeatherController.now = response
            }
        }
    }
    
    private func fetchCity() {
        guard let currentLoaction = currentLoaction else {
            return
        }

        CLGeocoder().reverseGeocodeLocation(currentLoaction) { placemarks, error in
            if let error = error {
                dump(error)
            }
            else if let city = placemarks?.first?.locality {
                let l = Location(name: city, latitude: currentLoaction.coordinate.latitude, longidude: currentLoaction.coordinate.longitude)
                self.currentWeatherController.location = l
            }
        }
    }
    
    private lazy var locationManager: CLLocationManager = {
        let manager = CLLocationManager()
        manager.distanceFilter = 1000
        manager.desiredAccuracy = 1000
        return manager
    }()
    
    private func requestLocation() {
        locationManager.delegate = self
        
        if locationManager.authorizationStatus == .authorizedWhenInUse {
            locationManager.requestLocation()
        }
        else {
            locationManager.requestWhenInUseAuthorization()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupActiveNotification()
    }
    
    @objc func applicationDidBecomeActive(notification: NSNotification) {
        requestLocation()
    }

    private func setupActiveNotification(){
        NotificationCenter.default.addObserver(self, selector: #selector(applicationDidBecomeActive(notification:)), name: UIApplication.didBecomeActiveNotification, object: nil)
    }
}

extension RootViewController: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            currentLoaction = location
            manager.delegate = nil
            
            manager.stopUpdatingHeading()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            manager.requestLocation()
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        dump(error)
    }
}

extension RootViewController: CurrentWeatherViewControllerDetegate {
    func locationButtonPressed(controller: CurrentWeatherViewController) {
        
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        
    }
}

