//
//  AppConstants.swift
//  Practical_TensorIOT
//

import Foundation
import UIKit

struct AppConstants {

    //MARK: - Designs
    struct Designs {

        //MARK: - Fonts
        struct Fonts {

            static let InterBold16 = UIFont(name: "Inter-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
            static let InterRegular16 = UIFont(name: "Inter-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
            static let InterRegular14 = UIFont(name: "Inter-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
        }
    }

    //MARK: - All StoryBoard
    struct AllStoryBoard {

        static let Main = UIStoryboard(name: "Main", bundle: nil)
    }

    //MARK: - ViewController Names
    struct ViewControllerName {

        static let kSignInVC = "SignInVC"
        static let kSignUpVC = "SignUpVC"
        static let kDashboardVC = "DashboardVC"
    }

    //MARK: - Alert Messages
    struct AlertMessage {

        //General Error Messages
        static let msgError = "Oops! That didn't work. Please try later :("

        //Internet Connection Message
        static let msgNetworkConnection = "You are not connected to internet. Please connect and try again"

        //Camera, Images and ALbums Related Messages
        static let msgMicrophonePermission = "Please enable microphone access from privacy settings"
        static let msgPhotoLibraryPermission = "Please enable access for photos from Privacy Settings"
        static let msgCameraPermission = "Please enable camera access from Privacy Settings"
        static let msgNoCamera = "Device has no camera"

        //Validation Messages
        static let msgFullName = "Please enter full name"
        static let msgValidCharacterFullName = "Full name must contain atleast 2 characters and maximum 60 characters"
        static let msgValidFullName = "Please enter valid full name"

        static let msgUserName = "Please enter user name"

        static let msgEmail = "Please enter email address"
        static let msgValidEmail = "Please enter valid email address"

        static let msgPassword = "Please enter password"
        static let msgPasswordCharacter = "Password must contain atleast 8 characters and maximum 16 characters"
        static let msgValidPassword = "Password should contain atleast 8 characters, one uppercase letter, one letter"

        static let msgBio = "Please enter bio"

        //Logout Message
        static let msgLogoutTitle = "Are you sure?"
        static let msgLogoutDescription = "You will need to re-enter your email address and password to log back in"

        //Firebase Messages
        static let msgFirebaseSignUpSuccess = "You have successfully signed up"
        static let msgFirebaseVerifyEmailSent = "Please check your mailbox for verification"
        static let msgFirebaseOperationNotAllowed = "The given sign-in provider is disabled for this Firebase project. Enable it in the Firebase console, under the sign-in method tab of the Auth section"
        static let msgFirebaseEmailAlreadyInUse = "Email address is already in use by another account"
        static let msgFirebaseInvalidEmail = "Email address is badly formatted"
        static let msgFirebaseWeakPassword = "Password must be 6 characters long or more"
        static let msgFirebaseVerifyEmail = "Please verify your email address"
        static let msgSignInFailed = "Sign in failed, could be a bad email or password or both. Please try again"
    }

    //MARK: - Web Service URLs
    struct WebServiceURL {

        static let mainURL = "https://api.openweathermap.org/data/2.5/"

        static let weatherURL = mainURL + "weather?"

        static let iconURL = "https://openweathermap.org/img/wn/"
    }

    //MARK: - Web Service Parameters
    struct WebServiceParameter {

        static let pEmail = "email"
        static let pPassword = "password"
        static let pLat = "lat"
        static let pLon = "lon"
        static let pSearch = "q"
        static let pUnits = "units"
        static let pAppId = "appid"
    }

    //MARK: - User Default Keys
    struct UserDefaultKeys {

        static let kEmailID = "email_id"
        static let kPassword = "password"
        static let kUserId = "user_id"

        static let kPreviousStateDate = "previous_state_date"

        static let kIsKeyChain = "isKeyChain"
    }

    //MARK: - Open Weather APIKey
    struct OpenWeather {

        static let pAPIKey = "641920ded070e33db0a775210664b36d"
    }

    //MARK: - Firebase Database & Storage
    struct Firebase {

        static let databaseUser = "Users"
        static let storageProfilePics = "Profile Pics/"
    }

    //MARK: - DateTime Format
    struct DateAndTimeFormatString {

        static let strDateFormat_yyyymmddHHmmss = "yyyy-MM-dd HH:mm:ss"
        static let strDateFormat_yyyyMMdd = "yyyy/MM/dd"
        static let strDateFormate_hhmma = "hh:mm a"
    }
}
