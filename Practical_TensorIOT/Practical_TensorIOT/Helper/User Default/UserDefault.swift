//
//  UserDefault.swift
//  Practical_TensorIOT
//

import Foundation

//MARK: - User Default
struct UserDefault {

    //MARK: - UserDefault Methods
    func setUserDefault<T>(_ object : T  , key : String) {
        let defaults = UserDefaults.standard
        defaults.set(object, forKey: key)
        UserDefaults.standard.synchronize()
    }

    func getUserDefault(_ key: String) -> AnyObject? {
        let defaults = UserDefaults.standard

        if let name = defaults.value(forKey: key){
            return name as AnyObject?
        }
        return nil
    }

    func isKeyPresentInUserDefaults(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }
}
