//
//  SignInVC.swift
//  Practical_TensorIOT
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class SignInVC: UIViewController {

    //MARK: - UITextField Outlets
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    //MARK: - UIButton Outlet
    @IBOutlet weak var btnSignIn: UIButton!

    //MARK: - Variable Declaration
    lazy var objSignInViewModel = SignInViewModel()

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()

        setCredentials()
    }

    //MARK: - Initialization Method
    private func initialization() {
        hideNavigationBar(isTabbar: false)
    }

    //MARK: - Set Credentials Method
    func setCredentials() {

        let objCredentials = objSignInViewModel.fetchCredentials()

        if objCredentials.emailId != "" && objCredentials.password != "" {

            txtEmailId.text = objCredentials.emailId
            txtPassword.text = objCredentials.password

            btnSignIn.backgroundColor = .appPrimaryColor()

            btnSignIn.isUserInteractionEnabled = true
        } else {
            btnSignIn.backgroundColor = .appGrayColor()

            btnSignIn.isUserInteractionEnabled = false
        }
    }

    //MARK: - UIButton Action Methods
    @IBAction func btnSignInAction(_ sender: Any) {

        Utility().hideIQKeyboard()

        if objSignInViewModel.checkValidations(emailId: txtEmailId, password: txtPassword) {
            objSignInViewModel.wsSignIn(emailId: txtEmailId.text ?? "", password: txtPassword.text ?? "") { [weak self] success in

                guard self != nil else { return }

                if success {
                    let objDashboardVC = AppConstants.AllStoryBoard.Main.instantiateViewController(withIdentifier: AppConstants.ViewControllerName.kDashboardVC) as? DashboardVC
                    let navigationViewController = UINavigationController(rootViewController: objDashboardVC!)
                    GlobalVariables.shared.appDelegate?.window?.rootViewController = navigationViewController
                    GlobalVariables.shared.appDelegate?.window?.makeKeyAndVisible()
                }
            }
        }
    }

    @IBAction func btnCreateAccountAction(_ sender: Any) {

        Utility().hideIQKeyboard()

        let objSignUpVC = AppConstants.AllStoryBoard.Main.instantiateViewController(withIdentifier: AppConstants.ViewControllerName.kSignUpVC) as! SignUpVC
        self.navigationController?.pushViewController(objSignUpVC, animated: true)
    }
}
