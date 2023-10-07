//
//  SignInViewModel.swift
//  Practical_TensorIOT
//

import FirebaseAuth
import SwiftKeychainWrapper
import Foundation

class SignInViewModel {

    //MARK: - Fetch Credentials Method
    internal func fetchCredentials() -> (emailId: String, password: String) {

        let strEmailID = UserDefaults.standard.string(forKey: AppConstants.UserDefaultKeys.kEmailID) ?? ""

        let strPassword = KeychainWrapper.standard.string(forKey: AppConstants.UserDefaultKeys.kPassword) ?? ""

        return (strEmailID, strPassword)
    }

    //MARK: - Check Validations Method
    internal func checkValidations(emailId: UITextField, password: UITextField) -> Bool {

        if emailId.isEmpty {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgEmail)
            return false
        } else if !emailId.validateEmail() {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgValidEmail)
            return false
        } else if password.isEmpty {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgPassword)
            return false
        } else if !password.checkMinAndMaxLength(withMinLimit: 8, withMaxLimit: 16) {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgPasswordCharacter)
            return false
        } else {
            return true
        }
    }

    //MARK: - Webservice SignIn Method
    internal func wsSignIn(emailId: String, password: String) {

        guard case NetworkCheck.isConnectedToNetwork() = true else {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgNetworkConnection)
            return
        }

        APIManager.apiFirebaseSignIn(strEmail: emailId, strPassword: password) { [weak self] (success, responseData, error)  in

            guard let self else { return }

            if success, let dictUserDetails = Auth.auth().currentUser {

                UserDefault().setUserDefault(dictUserDetails.uid, key: AppConstants.UserDefaultKeys.kUserId)
                UserDefault().setUserDefault(emailId, key: AppConstants.UserDefaultKeys.kEmailID)

                KeychainWrapper.standard.set(password, forKey: AppConstants.UserDefaultKeys.kPassword)

                UserDefault().setUserDefault(true, key: AppConstants.UserDefaultKeys.kIsKeyChain)

                Utility().setRootDashboardVC()

            } else if let error = error as NSError?, let authErrorCode = AuthErrorCode.Code(rawValue: error.code) {

                switch authErrorCode {

                case .operationNotAllowed:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseOperationNotAllowed)

                case .emailAlreadyInUse:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseEmailAlreadyInUse)

                case .invalidEmail:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseInvalidEmail)

                case .unverifiedEmail:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseVerifyEmail)

                default:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgSignInFailed)
                }
            }
        }
    }
}
