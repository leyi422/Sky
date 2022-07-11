//
//  Configuration.swift
//  Sky
//
//  Created by 张家玮 on 2022/7/11.
//

import Foundation

struct API {
    static let key = "29768f1ead069d7046e2226423bf21c2"
    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticateURL = baseURL.appendingPathComponent(key)
}
