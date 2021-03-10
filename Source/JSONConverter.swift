//
//  JSONConverter.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 25.02.2021.
//

import Foundation

// MARK: - JSONConverter

open class JSONConverter {
    
    // MARK: - Types
    
    typealias JSON = Any
    
    enum Error: Swift.Error {
        
        case parsing
    }
    
    // MARK: - Encode
    
    class func encode<T: Encodable>(
        
        object               : T,
        dataEncodingStrategy : JSONEncoder.DateEncodingStrategy = .deferredToDate
        
    ) throws -> Data {
        
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = dataEncodingStrategy
        
        return try encoder.encode(object)
    }
    
    class func encode(
        
        json    : JSON,
        options : JSONSerialization.WritingOptions = []
        
    ) throws -> Data {
        
        return try JSONSerialization.data(withJSONObject: json, options: options)
    }
    
    class func encode(
        
        dictionary : [String : Any],
        options    : JSONSerialization.WritingOptions = []
        
    ) throws -> Data {
        
        return try encode(json: dictionary, options: options)
    }
    
    class func encode(
        
        jsonString : String,
        options    : JSONSerialization.WritingOptions = []
        
    ) throws -> Data {
        
        return try encode(object: jsonString)
    }
    
    
    // MARK: - Decode
    
    class func decode<T: Decodable>(
        
        _ type               : T.Type,
        data                 : Data,
        dateDecodingStrategy : JSONDecoder.DateDecodingStrategy = .deferredToDate
        
    ) throws -> T {
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = dateDecodingStrategy
        
        return try decoder.decode(type, from: data)
    }
    
    class func decode<T: Decodable>(
        
        _ type               : T.Type,
        json                 : JSON,
        dateDecodingStrategy : JSONDecoder.DateDecodingStrategy = .deferredToDate
        
    ) throws -> T {
        
        let data = try encode(json: json)
        
        return try decode(type, data: data, dateDecodingStrategy: dateDecodingStrategy)
    }
    
    class func decode<T: Decodable>(
        
        _ type               : T.Type,
        dictionary           : [String: Any],
        dateDecodingStrategy : JSONDecoder.DateDecodingStrategy = .deferredToDate
        
    ) throws -> T {
        
        let data = try encode(dictionary: dictionary)
        
        return try decode(type, data: data, dateDecodingStrategy: dateDecodingStrategy)
    }
    
    class func decode(
        
        data    : Data,
        options : JSONSerialization.ReadingOptions = []
        
    ) throws -> [String: Any] {
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
        
        guard let result = jsonObject as? [String: Any] else {
            
            throw Error.parsing
        }
        
        return result
    }
    
    class func decode(
        
        data    : Data,
        options : JSONSerialization.ReadingOptions = []
        
    ) throws -> String {
        
        let jsonObject = try JSONSerialization.jsonObject(with: data, options: options)
        
        guard let result = jsonObject as? String else {
            
            throw Error.parsing
        }
        
        return result
    }
}
