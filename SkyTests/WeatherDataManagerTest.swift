//
//  WeatherDataManagerTest.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/11.
//

import XCTest
@testable import Sky

class WeatherDataManagerTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func test_weatherDataAt_starts_the_session() throws {
        let session = MockURLSession()
        
        let manager = WeatherDataManager(baseURL: URL(string: "https://darksky.net")!, urlSession: session)
        
        manager.weatherDataAt(latitude: 52, longitude: 100) { _, _ in }
        
        XCTAssert(session.sessionDataTask.isResumeCalled)
    }

}
