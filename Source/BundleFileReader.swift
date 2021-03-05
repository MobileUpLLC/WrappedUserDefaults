//
//  BundleFileReader.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 05.03.2021.
//

import Foundation

// MARK: - BundleFileReaderError

enum BundleFileReaderError: Error {
    
    case missingFile(String)
}

// MARK: - BundleFileReader

open class BundleFileReader {
    
    // MARK: - Public methods
    
    static func readObject<T: Decodable>(name: String) throws -> T {
        
        let data = try readData(name: name, withExtension: "json")
        
        return try JSONConverter.decode(T.self, data: data)
    }
    
    static func readJSON(name: String) throws -> Any {
        
        let data = try readData(name: name, withExtension: "json")
        
        return  try JSONConverter.decode(data: data)
    }
    
    static func readData(name: String, withExtension ext: String) throws -> Data {
        
        guard let url = Bundle.main.url(forResource: name, withExtension: ext) else {
            
            throw BundleFileReaderError.missingFile(
                "Bundle data with name: \(name) and extension: \(ext) couldn't be read"
            )
        }
        
        return try Data(contentsOf: url)
    }
}
