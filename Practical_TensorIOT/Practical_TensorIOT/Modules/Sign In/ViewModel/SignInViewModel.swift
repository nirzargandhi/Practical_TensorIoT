//
//  SignInViewModel.swift
//  Practical_TensorIOT
//

import Foundation
import SwiftKeychainWrapper
import FirebaseAuth

class SignInViewModel {

    internal func fetchCredentials() -> (emailId: String, password: String) {

        let strEmailID = UserDefaults.standard.string(forKey: AppConstants.UserDefaultKeys.kEmailID) ?? ""

        let strPassword = KeychainWrapper.standard.string(forKey: AppConstants.UserDefaultKeys.kPassword) ?? ""

        return (strEmailID, strPassword)
    }

    //MARK: -
    func wsSignIn(strEmail : String, strPassword : String, completion : @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {

        Utility().showLoader()

        Auth.auth().signIn(withEmail: strEmail, password: strPassword) { (authResult, error) in

            if error == nil {
                completion(true, authResult, error)
            } else {
                completion(false, authResult, error)
            }

            Utility().hideLoader()
        }
    }
}
