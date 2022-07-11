//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/11.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {
    let url = URL(string: "https://darksky.net")!
    var session: MockURLSession!
    var manager: WeatherDataManager!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        session = MockURLSession()
        manager = WeatherDataManager(baseURL: url, urlSession: session)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_weatherDataAt_starts_the_session() throws {
        manager.weatherDataAt(latitude: 52, longitude: 100) { _, _ in }
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }
    
    func test_weatherDataAt_handle_invalid_request() {
        session.responseError = NSError(domain: "Invalid Request", code: 100, userInfo: nil)
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { _, e in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_statuscode_not_equal_to_200() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 400, httpVersion: nil, headerFields: nil)

        let data = "{}".data(using: .utf8)
        session.responseData = data
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { _, e in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.failedRequest)
    }
    
    func test_weatherDataAt_handle_invalid_response() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = "{".data(using: .utf8)
        session.responseData = data
        
        var error: DataManagerError? = nil
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { _, e in
            error = e
        }
        
        XCTAssertEqual(error, DataManagerError.invalidResponse)
    }
    
    func test_weatherDataAt_handle_response_decode() {
        session.responseHeader = HTTPURLResponse(url: URL(string: "https://darksky.net")!, statusCode: 200, httpVersion: nil, headerFields: nil)
        
        let data = """
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
        """.data(using: .utf8)
        session.responseData = data
        
        var decoded: WeatherData? = nil
        manager.weatherDataAt(latitude: 52, longitude: 100) { d, _ in
            decoded = d
        }

        let expected = WeatherData(latitude: 52, longitude: 100, currently: WeatherData.CurrentWeather(time: Date(timeIntervalSince1970: 1657525822), summary: "Overcast", icon: "cloudy", temperature: 55.96, humidity: 0.5))
        XCTAssertEqual(decoded, expected)
    }

}
