//
//  UserDefaultsBackedWrapperTests.swift
//  Tests
//
//  Created by Denis Sushkov on 03.03.2021.
//

import XCTest

@testable import WrappedUserDefaults

class UserDefaultsBackedWrapperTests: XCTestCase {
    
    @UserDefaultsBacked<Int>(key: "keyForInteger", defaultValue: 13)
    var sutInt
    
    @UserDefaultsBacked<Bool>(key: "keyForBool", defaultValue: false)
    var sutBool
    
    override func setUp() {
        
        super.setUp()
        
        sutInt = 123456
        
        sutBool = true
    }
    
    func testWrapper() {
        
        let testCompare = UserDefaults.standard.value(forKey: "keyForInteger")
        
        let sutCompare = UserDefaults.standard.value(forKey: "keyForBool")
        
        XCTAssertEqual(sutInt, testCompare as! Int)
        XCTAssertEqual(sutBool, sutCompare as! Bool)
    }
    
    func testClearAll() {
        
        let initialCount = (UserDefaults.standard.dictionaryRepresentation().keys).count
        
        UserDefaults.standard.clearAll()
        
        let finalCount = (UserDefaults.standard.dictionaryRepresentation().keys).count
        
        XCTAssertNotEqual(initialCount, finalCount)
        XCTAssertNotEqual(finalCount, 0)
    }
    
    override func tearDown() {
        
        super.tearDown()
        
        UserDefaults.standard.clearAll()
    }
}
