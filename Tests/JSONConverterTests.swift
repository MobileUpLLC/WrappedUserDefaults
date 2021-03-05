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
        
        let testObject = 434.33
        
        do {
            
            let encodedData = try sut.encode(object: testObject)
            
            let decodedData = try sut.decode(Double.self, data: encodedData)
            
            XCTAssertEqual(decodedData, testObject)
            
        } catch {
            
            XCTFail()
        }
    }
    
    func testDictionaryEncoding() {

        let dictionary: [String: Any] = ["One": 1, "Two": "Два", "Three": 0.47, "Four": true]

        do {

            let encodedData = try sut.encode(dictionary: dictionary)

            let decodedData = try sut.decode(data: encodedData) as [String: Any]
            //КАК СРАВНИТЬ СЛОВАРИ?
            XCTAssertEqual(decodedData.keys, dictionary.keys)

        } catch {

            XCTFail()
        }
    }
    
    func testJsonStringEncoding() {
        
        guard let path = Bundle(for: type(of: self)).path(forResource: "array", ofType: "json") else { return XCTFail() }
        
        do {
            
            let jsonString = try String(contentsOfFile: path)
            
            let encodedData = try sut.encode(jsonString: jsonString)
            
            let decodedData = try sut.decode(String.self, data: encodedData)
            
            XCTAssertEqual(jsonString, decodedData)
            
        } catch {
            
            XCTFail()
        }
    }
    
    func testJsonEncoding() {
        
        guard let url = Bundle(for: type(of: self)).url(forResource: "dictionary", withExtension: "json") else { return XCTFail() }
        
        do {
            
            let json = try Data(contentsOf: url)
            
            let encodedData = try JSONConverter.encode(json: json)
            
            let decodedData = try JSONConverter.decode(Data.self, data: encodedData)
            
            XCTAssertEqual(json, decodedData)
            
        } catch {
            
            XCTFail()
        }
    }
}
