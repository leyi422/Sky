//
//  MockURLSession.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/11.
//

import Foundation
@testable import Sky

class MockURLSession: URLSessionProtocol {
    var sessionDataTask = MockURLSessionDataTask()
    
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTaskProtocol {
        return sessionDataTask
    }
}
