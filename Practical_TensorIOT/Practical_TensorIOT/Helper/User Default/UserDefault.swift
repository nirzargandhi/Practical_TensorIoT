//
//  UserDefault.swift
//  Practical_TensorIOT
//

import Foundation
import SwiftKeychainWrapper

//MARK: - User Default
struct UserDefault {

    //MARK: - Set & Get UserDefault Methods
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

    //MARK: - Is Key Present UserDefaults Method
    func isKeyPresentInUserDefault(key: String) -> Bool {
        return UserDefaults.standard.object(forKey: key) != nil
    }

    //MARK: - UserDefault & KeyChain Data Clear Method
    func userDefaultKeyChainDataClear() {

        UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultKeys.kEmailID)
        UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultKeys.kUserId)

        KeychainWrapper.standard.removeObject(forKey: AppConstants.UserDefaultKeys.kPassword)

        UserDefaults.standard.removeObject(forKey: AppConstants.UserDefaultKeys.kIsKeyChain)
        UserDefaults.standard.synchronize()
    }
}
