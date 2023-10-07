//
//  Constants.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - StoryBoard Identifier's
enum AllStoryBoard {

    static let Main = UIStoryboard(name: "Main", bundle: nil)
}

//MARK: - ViewController Names
enum ViewControllerName {

    static let kSignInVC = "SignInVC"
}

//MARK: - Cell Identifiers
enum CellIdentifiers {

}

//MARK: - Messages
enum AlertMessage {

    //General Error Messages
    static let msgError = "Oops! That didn't work. Please try later :("
}

//MARK: - Fonts
enum Fonts {

    static let InterBold16 = UIFont(name: "Inter-Bold", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .bold)
    static let InterRegular16 = UIFont(name: "Inter-Regular", size: 16) ?? UIFont.systemFont(ofSize: 16, weight: .regular)
    static let InterRegular14 = UIFont(name: "Inter-Regular", size: 14) ?? UIFont.systemFont(ofSize: 14, weight: .regular)
}

