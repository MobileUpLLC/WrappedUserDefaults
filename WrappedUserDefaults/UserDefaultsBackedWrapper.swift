//
//  UserDefaultsBackedWrapper.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 25.02.2021.
//

//import Foundation
//
//@propertyWrapper struct UserDefaultsBacked<Value> {
//    
//    var wrappedValue: String {
//        get { loadFromLocalStorage() }
//        set { saveToLocalStorage(object: newValue) }
//    }
//    
//    init(wrappedValue: String) {
//        self.wrappedValue = wrappedValue
//    }
//    
//    private func saveToLocalStorage<T: Encodable> (object: T) {
//        
//        do {
//            
//            let data = try JSONConverter.encode(object: object)
//            
//            var defaults = UserDefaults.standard.persistentDomain(forName: UserDefaults.propertyWrapperDomain)
//            
//            defaults += ["": data]?
//            
//            UserDefaults.standard.setPersistentDomain(["": data], forName: UserDefaults.propertyWrapperDomain)
//            
//        } catch {
//            
//            return 
//            
//        }
//        
//    }
//    
//    private func loadFromLocalStorage() -> String {
//        
//        do  {
//            
//            let object
//        }
//    }
//}
