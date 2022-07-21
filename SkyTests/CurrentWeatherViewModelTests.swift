//
//  CurrentWeatherViewModelTests.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/21.
//

import XCTest
@testable import Sky

class CurrentWeatherViewModelTests: XCTestCase {
    var vm: CurrentWeatherViewModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        
        let data = loadDataFromBundle(ofName: "DarkSky", ext: "json")
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        let weatherData = try! decoder.decode(WeatherData.self, from: data)
        
        vm = CurrentWeatherViewModel()
        vm.weather = weatherData
        
        let location = Location(name: "Test City", latitude: 100, longidude: 100)
        vm.location = location
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.dateMode)
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.temperatureMode)
    }

    func test_city_name_display() {
        XCTAssertEqual(vm.city, "Test City")
    }
    
    func test_date_display_in_text_mode() {
        let dateMode = DateMode.text
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        
        XCTAssertEqual(vm.date, "Thu, 05 October")
    }
    
    func test_date_display_in_digit_mode() {
        let dateMode = DateMode.digit
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        
        XCTAssertEqual(vm.date, "Thursday, 10/05")
    }
    
    func test_weather_summary_display() {
        XCTAssertEqual(vm.summary, "Light Snow")
    }
    
    func test_temperature_display_in_celsius_mode() {
        let temperatureMode = TemperatureMode.celsius
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        
        XCTAssertEqual(vm.temperature, "-5.0 ℃")
    }
    
    func test_temperature_display_in_fahenheit_mode() {
        let temperatureMode = TemperatureMode.fahrenheit
        UserDefaults.standard.set(temperatureMode.rawValue, forKey: UserDefaultsKeys.temperatureMode)
        
        XCTAssertEqual(vm.temperature, "23.0 °F")
    }
    
    func test_hummidity_display() {
        XCTAssertEqual(vm.humidity, "91.0 %")
    }
    
    func test_weather_icon_display() {
        let iconFromViewModel = vm.weatherIcon.pngData()
        let iconFromTestData = UIImage(named: "snow")!.pngData()
        
        XCTAssertEqual(vm.weatherIcon.size.width, 116.0)
        XCTAssertEqual(vm.weatherIcon.size.height, 108.0)
        XCTAssertEqual(iconFromViewModel, iconFromTestData)
    }

}
