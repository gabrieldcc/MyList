//
//  MylistDAO.swift
//  MyList
//
//  Created by Gabriel de Castro Chaves on 26/10/23.
//

import Foundation

enum MyListUserDefaultKeys: String {
    case itensList = "itensList"
}


final class MyListUserDefault {
    
    static func save(object: Any, with key: MyListUserDefaultKeys) {
        UserDefaults.standard.set(object, forKey: key.rawValue)
    }
    
    static func getObject(with key: MyListUserDefaultKeys) -> [String] {
        guard let storedObjects = UserDefaults.standard.object(forKey: key.rawValue) as? [String] else {
            return []
        }
        return storedObjects
    }
}

