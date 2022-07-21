//
//  XCTestCase.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/21.
//

import XCTest

extension XCTestCase {
    func loadDataFromBundle(ofName name: String, ext: String) -> Data {
        let bundle = Bundle(for: type(of: self))
        let url = bundle.url(forResource: name, withExtension: ext)
        
        return try! Data(contentsOf: url!)
    }
}
