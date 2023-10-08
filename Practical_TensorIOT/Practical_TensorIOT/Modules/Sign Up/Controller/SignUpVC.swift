//
//  SignUpVC.swift
//  Practical_TensorIOT
//

import UIKit

class SignUpVC: UIViewController {

    //MARK: - UIImageView Outlet
    @IBOutlet weak var imgvProfilePic: UIImageView!

    //MARK: - UITextField Outlets
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtUsername: UITextField!
    @IBOutlet weak var txtEmailId: UITextField!
    @IBOutlet weak var txtPassword: UITextField!

    //MARK: - UITextView Outlet
    @IBOutlet weak var tvBio: UITextView!

    //MARK: - UIButton Outlet
    @IBOutlet weak var btnSignUp: UIButton!

    //MARK: - Variable Declaration
    lazy var objSignUpViewModel = SignUpViewModel()
    lazy var dataProfilePic = Data()

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }

    //MARK: - Initialization Method
    private func initialization() {

        hideNavigationBar(isTabbar: false)

        tvBio.contentInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }

    //MARK: - UIButton Action Methods
    @IBAction func btnBackAction(_ sender: Any) {

        Utility().hideIQKeyboard()

        self.navigationController?.popViewController(animated: true)
    }

    @IBAction func btnAddProfilePicAction(_ sender: Any) {

        Utility().hideIQKeyboard()

        takeAndChoosePhoto()
    }

    @IBAction func btnSignUpAction(_ sender: Any) {

        Utility().hideIQKeyboard()

        if objSignUpViewModel.checkValidations(name: txtFullName, username: txtUsername, emailId: txtEmailId, password: txtPassword, bio: tvBio) {
            objSignUpViewModel.wsSignUp(name: txtFullName.text ?? "", username: txtUsername.text ?? "", emailId: txtEmailId.text ?? "", password: txtPassword.text ?? "", bio: tvBio.text ?? "", profilePic: dataProfilePic ?? nil) {success in

                if success {
                    self.navigationController?.popViewController(animated: true)
                }
            }
        }
    }
}
