//
//  Date.swift
//  Sky
//
//  Created by 张家玮 on 2022/8/16.
//

import Foundation

extension Date {
    static func from(string: String) -> Date {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-mm-dd"
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+8:00")
        return dateFormatter.date(from: string)!
    }
}
