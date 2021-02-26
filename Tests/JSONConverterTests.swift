//
//  JSONConverterTests.swift
//  Tests
//
//  Created by Denis Sushkov on 25.02.2021.
//

import XCTest

@testable import WrappedUserDefaults

class JSONConverterTests: XCTestCase {
    
    var sut = JSONConverter.self
    
    func testDataEncoding() {
        
        let testObject = "This is a string for testing!"
        
        do {
            
            let encodedData = try sut.encode(object: testObject)
            
            let decodedData = try sut.decode(String.self, data: encodedData)
            
            XCTAssertEqual(decodedData, testObject)
            
        } catch {
            
            XCTFail()
        }
    }
    
    func testJsonEncoding() {

        
    }
    
//    func testDictionaryEncoding() {
//
//        let dictionary: [String: Any] = ["One": 1, "Two": "Два", "Three": 0.47, "Four": true]
//
//        do {
//
//            let encodedData = try sut.encode(dictionary: dictionary)
//
//            let decodedData = try sut.decode(data: encodedData) as [String: Any]
//
//            XCTAssertEqual(<#T##expression1: Equatable##Equatable#>, <#T##expression2: Equatable##Equatable#>)
//
//        } catch {
//
//            XCTFail()
//        }
//    }
    
    func testJsonStringEncoding() {
        
        let jsonString = "{\"names\": [\"Bob\", \"Tim\", \"Tina\"]}"
        
        do {
            
            let encodedData = try sut.encode(jsonString: jsonString)
            
            let decodedData = try sut.decode(data: encodedData) as String
            
            XCTAssertEqual(jsonString, decodedData)
            
        } catch {
            
            XCTFail()
        }
    }
}
