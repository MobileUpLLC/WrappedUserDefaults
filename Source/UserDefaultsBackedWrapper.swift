//
//  UserDefaultsBackedWrapper.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 25.02.2021.
//

import Foundation

// MARK: - UserDefaultsBacked

@propertyWrapper struct UserDefaultsBacked<Value: Codable> {
    
    // MARK: - Public properties
    
    let key: String
    let defaultValue: Value
    var container: UserDefaults = .standard
    
    var wrappedValue: Value {
        get { getFromLocalStorage(key: key) ?? defaultValue }
        set { saveToLocalStorage(key: key, object: newValue) }
    }
    
    // MARK: - Private methods
    
    private func getFromLocalStorage(key: String) -> Value? {
        
        let object = container.object(forKey: key)

        return object as? Value
    }
    
    private func saveToLocalStorage<Value> (key: String, object: Value) {
            
        container.setValue(object, forKey: key)
    }
}
