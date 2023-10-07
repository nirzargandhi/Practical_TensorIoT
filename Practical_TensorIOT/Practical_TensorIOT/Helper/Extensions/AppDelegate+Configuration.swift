//
//  AppDelegate+Configuration.swift
//  Practical_TensorIOT
//

import FirebaseCore
import IQKeyboardManagerSwift

//MARK: - AppDelegate Extension
extension AppDelegate {

    //MARK: - Config App Method
    func configApp() {

        setFirebase()

        setIQKeyboard()
        
        setRootController()
    }

    //MARK: - Set Firebase Method
    func setFirebase() {
        FirebaseApp.configure()
    }

    //MARK: - Set IQKeyboard Method
    func setIQKeyboard() {

        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.enableAutoToolbar = true
    }

    //MARK: - Set Root Controller Method
    func setRootController() {
        Utility().setRootSignInVC()
    }
}

