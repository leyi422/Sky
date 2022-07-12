//
//  CurrentWeatherUITests.swift
//  SkyUITests
//
//  Created by 张家玮 on 2022/7/12.
//

import XCTest

class CurrentWeatherUITests: XCTestCase {
    
    let app = XCUIApplication()

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
        app.launchArguments += ["UI_TESTING"]
        app.launchEnvironment["FakeJSON"] = """
        {
            "latitude": 52,
            "longitude": 100,
            "currently": {
                "time": 1657525822,
                "summary": "Overcast",
                "icon": "cloudy",
                "temperature": 55.96,
                "humidity": 0.5
            }
        }
        """
        app.launch()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_location_button_exists() throws {
        let locationBtn = app.buttons["LocationBtn"]
        XCTAssert(locationBtn.exists)
    }
    
    func test_current_weather_display() {
        XCTAssert(app.images["WeatherIcon"].exists)
        XCTAssert(app.staticTexts["SummaryLabel"].exists)
    }
}
