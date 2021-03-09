//
//  UserDefaultsArchivedWrapperTests.swift
//  Tests
//
//  Created by Denis Sushkov on 09.03.2021.
//

import XCTest

@testable import WrappedUserDefaults

class UserDefaultsArchivedWrapperTests: XCTestCase {
    
    @UserDefaultsArchived<TestingDictionaryStruct>(key: "keyForDictionary", defaultValue: TestingDictionaryStruct(integer: 0, float: 0, boolean: true, date: "", firstname:     ""))
    var sutDictionary
    
    @UserDefaultsArchived<TestingArrayStruct>(key: "keyForArray", defaultValue: TestingArrayStruct(name: "", age: 0))
    var sutArray
    
    override func setUp() {
        
        super.setUp()
        
        sutDictionary = TestingDictionaryStruct(integer: 123, float: 32.1, boolean: true, date: "12.09.1992", firstname: "John")
        
        sutArray = TestingArrayStruct(name: "Daniel", age: 33)
    }
    
    func testArchiver() {
        
        let wrappedDictionary = UserDefaults.standard.value(forKey: "keyForDictionary")
        
        let wrappedArray = UserDefaults.standard.value(forKey: "keyForArray")
        
        XCTAssertEqual(sutDictionary, wrappedDictionary as? TestingDictionaryStruct)
        XCTAssertEqual(sutArray, wrappedArray as? TestingArrayStruct)
    }
    
    override func tearDown() {
        
        UserDefaults.standard.clearAll()
        
        super.tearDown()
    }
}
