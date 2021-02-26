//
//  UserDefaultsBackedWrapper.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 25.02.2021.
//

import Foundation

@propertyWrapper struct UserDefaultsBacked<Value> {
    
    var wrappedValue: String {
        didSet { saveToLocalStorage(object: wrappedValue) }
    }
    
    init(wrappedValue: String) {
        self.wrappedValue = wrappedValue
    }
    
    func saveToLocalStorage<T: Encodable> (object: T) {
        
        do {
            
            let data = try JSONConverter.encode(object: object)
            
            
            
        } catch {
            
            return 
            
        }
        
    }
}
