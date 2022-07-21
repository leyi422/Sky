//
//  MockURLSessionDataTask.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/11.
//

import Foundation
@testable import Sky

class MockURLSessionDataTask: URLSessionDataTaskProtocol {
    private (set) var isResumeCalled = false
    
    func resume() {
        isResumeCalled = true
    }
}
