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
}
