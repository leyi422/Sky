//
//  RootViewController.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import UIKit
import CoreLocation
import RxSwift
import RxCocoa

class RootViewController: UIViewController {
    
    var currentWeatherController: CurrentWeatherViewController!
    var weekWeatherController: WeekWeatherViewController!
    
    private let segueCurrentWeather = "SegueCurrentWeather"
    private let segueWeekWeather = "SegueWeekWeather"
    private let segueSettings = "SegueSettings"
    private let segueLocations = "SegueLocations"
    
    private var bag = DisposeBag()
    
    @IBAction func unwindToRootViewController(segue: UIStoryboardSegue) {
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        guard let identifier = segue.identifier else {
            return
        }
        
        switch identifier {
        case segueCurrentWeather:
            guard let destination = segue.destination as? CurrentWeatherViewController else {
                fatalError("Invalid destination view controller.")
            }
            
            destination.delegate = self
            currentWeatherController = destination
        case segueWeekWeather:
            guard let destination = segue.destination as? WeekWeatherViewController else {
                fatalError("Invalid destination view controller.")
            }

            weekWeatherController = destination
        case segueSettings:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("Invalid destination view controller.")
            }
            
            guard let destination = navigationController.topViewController as? SettingsViewController else {
                fatalError("Invalid destination view controller.")
            }
            
            destination.delegate = self
        case segueLocations:
            guard let navigationController = segue.destination as? UINavigationController else {
                fatalError("Invalid destination view controller.")
            }
            
            guard let destination = navigationController.topViewController as? LocationsViewController else {
                fatalError("Invalid destination view controller.")
            }
            
            destination.delegate = self
            destination.currentLocation = currentLoaction
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

        let weather = WeatherDataManager.shared.weatherDataAt(latitude: lat, longitude: lon)
            .share(replay: 1, scope: .whileConnected)
            .observe(on: MainScheduler.instance)
        
        weather.map { CurrentWeatherViewModel(weather: $0) }
            .bind(to: currentWeatherController.weatherVM)
            .disposed(by: bag)
        
        weather.map { WeekWeatherViewModel(weatherData: $0.daily.data) }
            .subscribe (onNext: {
                self.weekWeatherController.viewModel = $0
            })
            .disposed(by: bag)

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
                let location = Location(name: city, latitude: currentLoaction.coordinate.latitude, longitude: currentLoaction.coordinate.longitude)
                self.currentWeatherController.locationVM.accept(CurrentLocationViewModel(location: location))
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
            locationManager.startUpdatingLocation()
            locationManager.rx.didUpdateLocations.take(1).subscribe(onNext: {
                print("update location")
                self.currentLoaction = $0.first
            }).disposed(by: bag)
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
        performSegue(withIdentifier: segueLocations, sender: self)
    }
    
    func settingsButtonPressed(controller: CurrentWeatherViewController) {
        performSegue(withIdentifier: segueSettings, sender: self)
    }
}

extension RootViewController: SettingsViewControllerDelegate {
    private func reloadUI() {
        currentWeatherController.updateView()
        weekWeatherController.updateView()
    }
    
    func controllerDidChangeDateMode(controller: SettingsViewController) {
        reloadUI()
    }
    
    func controllerDidChangeTemperatureMode(controller: SettingsViewController) {
        reloadUI()
    }
}

extension RootViewController: LocationsViewControllerDelegae {
    func controller(_ controller: LocationsViewController, didSelectLocation location: CLLocation) {
        currentLoaction = location
    }
}
