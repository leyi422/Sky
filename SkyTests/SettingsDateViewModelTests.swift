//
//  SettingsDateViewModelTests.swift
//  SkyTests
//
//  Created by 张家玮 on 2022/7/21.
//

import XCTest
@testable import Sky

class SettingsDateViewModelTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        UserDefaults.standard.removeObject(forKey: UserDefaultsKeys.dateMode)
    }

    func test_date_display_in_text_mode() {
        let vm = SettingsDateViewModel(dateMode: .text)
        XCTAssertEqual(vm.labelText, "Fri, 01 December")
    }
    
    func test_date_display_in_digut_mode() {
        let vm = SettingsDateViewModel(dateMode: .digit)
        XCTAssertEqual(vm.labelText, "F, 12/01")
    }
    
    func test_text_date_mode_selected() {
        let dateMode = DateMode.text
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingsDateViewModel(dateMode: dateMode)
        
        XCTAssertEqual(vm.accessory, UITableViewCell.AccessoryType.checkmark)
    }
    
    func test_text_date_mode_unselected() {
        let dateMode = DateMode.text
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingsDateViewModel(dateMode: .digit)
        
        XCTAssertEqual(vm.accessory, UITableViewCell.AccessoryType.none)
    }
    
    func test_digit_date_mode_selected() {
        let dateMode = DateMode.digit
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingsDateViewModel(dateMode: dateMode)
        
        XCTAssertEqual(vm.accessory, UITableViewCell.AccessoryType.checkmark)
    }
    
    func test_digit_date_mode_unselected() {
        let dateMode = DateMode.digit
        
        UserDefaults.standard.set(dateMode.rawValue, forKey: UserDefaultsKeys.dateMode)
        let vm = SettingsDateViewModel(dateMode: .text)
        
        XCTAssertEqual(vm.accessory, UITableViewCell.AccessoryType.none)
    }

}
