//
//  UserDefaultsArchivedWrapper.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 09.03.2021.
//

import Foundation

// MARK: - UserDefaultsArchived

@propertyWrapper struct UserDefaultsArchived<Value> {
    
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
        
        if let data = UserDefaults.standard.object(forKey: key) as? Data {
            
            return getUnarchivedObject(from: data)
            
        } else {
            
            return UserDefaults.standard.object(forKey: key) as? Value
        }
    }
    
    private func saveToLocalStorage<Value> (key: String, object: Value) {
        
        do {
            
            let archivedData = try NSKeyedArchiver.archivedData(withRootObject: object, requiringSecureCoding: false)
            
            container.set(archivedData, forKey: key)
            
        } catch {
            
            return
        }
    }
    
    private func getUnarchivedObject(from data: Data) -> Value? {
        
        do {
            
            return try NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? Value
            
        } catch {
            
            return nil
        }
    }
}
