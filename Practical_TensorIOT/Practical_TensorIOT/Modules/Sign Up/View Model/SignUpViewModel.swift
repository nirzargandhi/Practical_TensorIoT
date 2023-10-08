//
//  SignUpViewModel.swift
//  Practical_TensorIOT
//

import FirebaseAuth
import FirebaseDatabase
import FirebaseStorage
import SwiftKeychainWrapper
import Foundation

class SignUpViewModel {

    //MARK: - Check Validations Method
    internal func checkValidations(name: UITextField, username: UITextField, emailId: UITextField, password: UITextField, bio: UITextView) -> Bool {

        if name.isEmpty {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFullName)
            return false
        } else if !(name.checkMinAndMaxLength(withMinLimit: 2, withMaxLimit: 60)) {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgValidCharacterFullName)
            return false
        } else if !name.validateName() {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgValidFullName)
            return false
        } else if username.isEmpty {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgUserName)
            return false
        } else if emailId.isEmpty {
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
        } else if bio.text.isEmpty {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgBio)
            return false
        } else {
            return true
        }
    }

    //MARK: - Webservice SignUp Method
    internal func wsSignUp(name: String, username: String, emailId: String, password: String, bio: String, profilePic: Data?) {

        guard case NetworkCheck.isConnectedToNetwork() = true else {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgNetworkConnection)
            return
        }

        Utility().showLoader()

        APIManager.apiFirebaseSignUp(strEmail: emailId, strPassword: password) { [weak self] (success, responseData, error)  in

            Utility().hideLoader()

            guard let self else { return }

            if success, let dictUserDetails = Auth.auth().currentUser {

                Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseSignUpSuccess)

                UserDefault().setUserDefault(dictUserDetails.uid, key: AppConstants.UserDefaultKeys.kUserId)
                UserDefault().setUserDefault(emailId, key: AppConstants.UserDefaultKeys.kEmailID)

                KeychainWrapper.standard.set(password, forKey: AppConstants.UserDefaultKeys.kPassword)

                UserDefault().setUserDefault(true, key: AppConstants.UserDefaultKeys.kIsKeyChain)

                storeUserData(name: name, username: username, emailId: emailId, password: password, bio: bio, profilePic: profilePic, userDetails: dictUserDetails)

                //                popToBack()
            } else if let error = error as NSError?, let authErrorCode = AuthErrorCode.Code(rawValue: error.code) {

                switch authErrorCode {

                case .operationNotAllowed:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseOperationNotAllowed)

                case .emailAlreadyInUse:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseEmailAlreadyInUse)

                case .invalidEmail:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseInvalidEmail)

                case .weakPassword:
                    Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgFirebaseWeakPassword)

                default:
                    Utility().dynamicToastMessage(strMessage: error.localizedDescription)
                }
            }
        }
    }

    //MARK: - Store User Data Method
    private func storeUserData(name: String, username: String, emailId: String, password: String, bio: String, profilePic: Data?, userDetails : User) {

        let strDate = Utility().datetimeFormatter(strFormat: AppConstants.DateAndTimeFormatString.strDateFormat_yyyymmddHHmmss, isTimeZoneUTC: false).string(from: Date())

        var dictUserData = UserDataModel.init(timestamp: strDate, fullname: name, username: username, emailId: emailId, password: password, bio: bio, imgProfilePic: "")

        if let dictValues = dictUserData.values {
            Database.database().reference().child(AppConstants.Firebase.databaseUser).child(userDetails.uid).setValue(dictValues)
        }

        if let data = profilePic {

            let imageRef = Storage.storage().reference().child("\(AppConstants.Firebase.storageProfilePics)\(userDetails.uid).jpg")

            let uploadTask = imageRef.putData(data, metadata: nil) { (metadata, error) in

                guard metadata != nil else {
                    return
                }

                imageRef.downloadURL { (url, error) in

                    guard let downloadURL = url else {
                        return
                    }

                    dictUserData = UserDataModel.init(timestamp: strDate, fullname: name, username: username, emailId: emailId, password: password, bio: bio, imgProfilePic: downloadURL.absoluteString)

                    if let dictValues = dictUserData.values {
                        Database.database().reference().child(AppConstants.Firebase.databaseUser).updateChildValues([userDetails.uid : dictValues])
                    }
                }
            }

            uploadTask.resume()
        }
    }
}
