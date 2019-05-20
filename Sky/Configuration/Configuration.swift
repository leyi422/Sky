//
//  Configuration.swift
//  Sky
//
//  Created by Jiawei Zhang on 2019/5/20.
//  Copyright © 2019 ZhangJiawei. All rights reserved.
//

import Foundation

struct API {
    static let key = "29768f1ead069d7046e2226423bf21c2"
    static let baseURL = URL(string: "https://api.darksky.net/forecast/")!
    static let authenticatedURL = baseURL.appendingPathComponent(key)
}
