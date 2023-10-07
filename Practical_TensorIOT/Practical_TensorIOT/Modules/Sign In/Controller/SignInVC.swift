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

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }

    //MARK: - Initialization Method
    private func initialization() {
        hideNavigationBar(isTabbar: false)
    }

    //MARK: - UIButton Action Methods
    @IBAction func btnSignInAction(_ sender: Any) {
    }

    @IBAction func btnCreateAccountAction(_ sender: Any) {
    }
}
