//
//  UserDefaultsBackedWrapper.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 25.02.2021.
//

import Foundation

// MARK: - WrapperType

enum WrapperType {
    
    case codable
    case json
    case dictionary
    case jsonString
    case primitive
}

// MARK: - UserDefaultsBacked

@propertyWrapper struct UserDefaultsBacked<Value> {
    
    // MARK: - Public properties
    
    let key: String
    let defaultValue: Value
    let type: WrapperType = .primitive
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get { getFromLocalStorage(key: key, type: type) ?? defaultValue }
        set { saveToLocalStorage(key: key, type: type, object: newValue) }
    }
    
    // MARK: - Private methods
    
    private func getFromLocalStorage(key: String, type: WrapperType) -> Value? {
        
        let object = container.object(forKey: key)

        if type == .primitive {

            return object as? Value

        } else {

            guard let object = object as? Data else { return nil }

            return decodeObject(object: object, type: type)
        }
    }
    
    private func decodeObject(object: Data, type: WrapperType) -> Value? {

        let decodedObject: Value? = nil

        do {

            switch type {

            case .codable    : decodedObject = try JSONConverter.decode(T:Decodable, data: object)
            case .dictionary : decodedObject = try JSONConverter.decode(data: object)
            case .jsonString : decodedObject = try JSONConverter.decode(data: object)
            default          : return nil
                
            }

        } catch {

            return nil
        }
    }
    
    private func saveToLocalStorage<Value> (key: String, type: WrapperType, object: Value) {
        
        if type == .primitive {
            
            container.setValue(object, forKey: key)
            
        } else {
            
            if let safeObject = encodeObject(object, type: type) {
                
                container.setValue(safeObject, forKey: key)
            }
        }
    }
    
    private func encodeObject(_ object: Value, type: WrapperType) -> Data? {
        
        do {

            switch type {

            case .codable    : return try JSONConverter.encode(object: object)
            case .dictionary : return try JSONConverter.encode(dictionary: object as? [String : Any] ?? [:])
            case .json       : return try JSONConverter.encode(json: object)
            case .jsonString : return try JSONConverter.encode(jsonString: object as? String ?? "")
            default          : return nil
    
            }

        } catch {

            return nil
        }
    }
}
