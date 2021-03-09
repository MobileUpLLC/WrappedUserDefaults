//
//  UserDefaultsArchivedWrapperTests.swift
//  Tests
//
//  Created by Denis Sushkov on 09.03.2021.
//

import XCTest

@testable import WrappedUserDefaults

class UserDefaultsArchivedWrapperTests: XCTestCase {
    
    @UserDefaultsArchived<ExampleStruct>(key: "keyForDictionary", defaultValue: ExampleStruct(integer: 0, float: 0, boolean: true, date: "", firstname:     ""))
    var sutDictionary
    
    @UserDefaultsArchived<Person>(key: "keyForArray", defaultValue: Person(name: "", age: 0))
    var sutArray
    
    override func setUp() {
        
        super.setUp()
        
        sutDictionary = ExampleStruct(integer: 123, float: 32.1, boolean: true, date: "2020-05-08T21:15:10Z", firstname: "John")
        
        sutArray = Person(name: "Daniel", age: 33)
    }
    
    func testArchiver() {
        
        let wrappedDictionary = UserDefaults.standard.value(forKey: "keyForDictionary")
        
        let wrappedArray = UserDefaults.standard.value(forKey: "keyForArray")
        
        XCTAssertEqual(sutDictionary, wrappedDictionary as? ExampleStruct)
        XCTAssertEqual(sutArray, wrappedArray as? Person)
    }
    
    override func tearDown() {
        
        UserDefaults.standard.clearAll()
        
        super.tearDown()
    }
}
