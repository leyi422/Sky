//
//  WeatherDataManager.swift
//  Sky
//
//  Created by Jiawei Zhang on 2019/5/21.
//  Copyright © 2019 ZhangJiawei. All rights reserved.
//

import Foundation

enum DataManagerError: Error {
    case failedRequest
    case invaildResponse
    case unknown
}

final class WeatherDataManager {
    private let baseURL: URL
    private init(baseURL: URL) {
        self.baseURL = baseURL
    }
    
    static let shared = WeatherDataManager(baseURL: API.authenticatedURL)
    
    typealias CompletionHandler = (WeatherData?, DataManagerError?) -> Void
    
    func weatherDataAt(latitude: Double, longitude: Double, completion: @escaping CompletionHandler) {
        let url = self.baseURL.appendingPathComponent("\(latitude),\(longitude)")
        var request = URLRequest(url: url)
        
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "GET"
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
                self.didFinishGettingWeatherData(data: data, response: response, error: error, completion: completion)
            }
        }
    }
    
    func didFinishGettingWeatherData(data: Data?, response: URLResponse?, error: Error?, completion: CompletionHandler) {
        if let _ = error {
            completion(nil, .failedRequest)
        }
        else if let data = data, let response = response as? HTTPURLResponse {
            if response.statusCode == 200 {
                do {
                    let weatherData = try JSONDecoder().decode(WeatherData.self, from: data)
                    completion(weatherData, nil)
                }
                catch {
                    completion(nil, .invaildResponse)
                }
            }
            else {
                completion(nil, .failedRequest)
            }
        }
        else {
            completion(nil, .unknown)
        }
    }
}
