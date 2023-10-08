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

        setRootSignInVC()
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

    //MARK: - Set Root SignInVC Method
    func setRootSignInVC() {
        let objSignInVC = AppConstants.AllStoryBoard.Main.instantiateViewController(withIdentifier: AppConstants.ViewControllerName.kSignInVC) as? SignInVC
        let navigationViewController = UINavigationController(rootViewController: objSignInVC!)
        GlobalVariables.shared.appDelegate?.window?.rootViewController = navigationViewController
        GlobalVariables.shared.appDelegate?.window?.makeKeyAndVisible()
    }
}

