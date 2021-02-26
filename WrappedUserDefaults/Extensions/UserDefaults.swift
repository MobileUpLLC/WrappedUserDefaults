//
//  UserDefaults.swift
//  WrappedUserDefaults
//
//  Created by Denis Sushkov on 25.02.2021.
//

import Foundation

extension UserDefaults {
    
    // MARK: - Public properties
    
    static let propertyWrapperDomain = "propertyWrapperDomain"
    
    // MARK: - Public methods
    
    public func clearAll() {
        
        UserDefaults.standard.removePersistentDomain(forName: UserDefaults.propertyWrapperDomain)
        
        UserDefaults.standard.synchronize()
    }
}
