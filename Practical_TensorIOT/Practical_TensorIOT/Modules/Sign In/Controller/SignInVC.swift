//
//  SignInVC.swift
//  Practical_TensorIOT
//

import UIKit

class SignInVC: UIViewController {

    //MARK: - UITextField Outlets
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    //MARK: - UILabel Outlet
    @IBOutlet weak var lblValidMessage: UILabel!

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
    }

    @IBAction func btnCreateAccountAction(_ sender: Any) {
    }

    //MARK: - Hide Valid Message Method
    internal func hideValidMessage() {
        lblValidMessage.text = ""
        lblValidMessage.isHidden = true
    }
}
