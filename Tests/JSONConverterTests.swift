//
//  JSONConverterTests.swift
//  Tests
//
//  Created by Denis Sushkov on 25.02.2021.
//

import XCTest

@testable import WrappedUserDefaults

struct ExampleStruct: Codable, Equatable {
    
    let integer: Int
    let float: Float
    let boolean: Bool
    let date: String
    let firstname: String
}

struct Person: Codable, Equatable {
    
    let name: String
    let age: Int
}

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
            
            XCTAssertEqual(NSDictionary(dictionary: dictionary, copyItems: false), NSDictionary(dictionary: decodedData, copyItems: false))

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
    
    func testJsonDictionaryEncoding() {
        
        let testBundle = Bundle(for: type(of: self))
        
        do {
            
            let initialDecodedData = try BundleFileReader.readJSON(name: "dictionary", into: ExampleStruct.self, bundle: testBundle) as? ExampleStruct
            
            let encodedData = try JSONConverter.encode(object: initialDecodedData)
            
            let finalDecodedData = try JSONConverter.decode(ExampleStruct.self, data: encodedData)
            
            XCTAssertNotNil(initialDecodedData)
            XCTAssertEqual(initialDecodedData, finalDecodedData)
            
        } catch {
            
            XCTFail()
        }
    }
    
    func testJsonArrayEncoding() {
        
        let testBundle = Bundle(for: type(of: self))
        
        do {
            
            let initialDecodedData = try BundleFileReader.readJSON(name: "array", into: [Person].self, bundle: testBundle) as? [Person]
            
            let encodedData = try JSONConverter.encode(object: initialDecodedData)
            
            let finalDecodedData = try JSONConverter.decode([Person].self, data: encodedData)
            
            XCTAssertNotNil(initialDecodedData)
            XCTAssertEqual(initialDecodedData, finalDecodedData)
            
        } catch {
            
            XCTFail()
        }
    }
}
