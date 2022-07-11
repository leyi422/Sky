//
//  URLSessionProtocol.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import Foundation

protocol URLSessionProtocol {
    typealias dataTaskHandler = (Data?, URLResponse?, Error?) -> Void
    
    func dataTask(with request: URLRequest, completionHandler: @escaping dataTaskHandler) -> URLSessionDataTaskProtocol
}
