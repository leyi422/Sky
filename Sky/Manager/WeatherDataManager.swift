//
//  WeatherDataManager.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import Foundation
import RxSwift
import RxCocoa

internal class DarkSkyURLSession: URLSessionProtocol {
    func dataTask(with request: URLRequest, completionHandler: @escaping DataTaskHandler) -> URLSessionDataTaskProtocol {
        return DarkSkyURLURLSessionDataTask(request: request, completion: completionHandler)
    }
}

internal class DarkSkyURLURLSessionDataTask: URLSessionDataTaskProtocol {
    private let request: URLRequest
    private let completion: DataTaskHandler
    
    init(request: URLRequest, completion: @escaping DataTaskHandler) {
        self.request = request
        self.completion = completion
    }
    
    func resume() {
        if let json = ProcessInfo.processInfo.environment["FakeJSON"] {
            let response = HTTPURLResponse(url: request.url!, statusCode: 200, httpVersion: nil, headerFields: nil)
            let data = json.data(using: .utf8)
            
            completion(data, response, nil)
        }
    }
}

internal struct Config {
    private static var isUITesting: Bool {
        return ProcessInfo.processInfo.arguments.contains("UI_TESTING")
    }
    
    static var urlSession: URLSessionProtocol = {
        if isUITesting {
            return DarkSkyURLSession()
        }
        else {
            return URLSession.shared
        }
    }()
}

enum DataManagerError: Error {
    case failedRequest
    case invalidResponse
    case unknown
}

final class WeatherDataManager {
    internal let baseURL: URL
    internal let urlSession: URLSessionProtocol
    internal init(baseURL: URL, urlSession: URLSessionProtocol) {
        self.baseURL = baseURL
        self.urlSession = urlSession
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticateURL, urlSession: Config.urlSession)
    
    func weatherDataAt(latitude: Double, longitude: Double) -> Observable<WeatherData> {
        let url = baseURL.appendingPathComponent("\(latitude),\(longitude)")
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"

        return (urlSession as! URLSession).rx.data(request: request)
            .map {
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .secondsSince1970
                let weatherData = try decoder.decode(WeatherData.self, from: $0)
                
                return weatherData
            }
            .materialize()
            .do(onNext: { print("DO: \($0)") })
            .dematerialize()
    }
}
