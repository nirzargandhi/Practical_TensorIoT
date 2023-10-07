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

    //MARK: - UILabel Outlet
    @IBOutlet weak var lblValidMessage: UILabel!

    //MARK: - UIButton Outlet
    @IBOutlet weak var btnSignUp: UIButton!

    //MARK: - Variable Declaration
    var dataProfilePic : Data?

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }

    //MARK: - Initialization Method
    private func initialization() {

        hideNavigationBar(isTabbar: false)

        //tvBio.contentInset = UIEdgeInsets(top: 0, left: kPlaceholderTextViewInsetSpan, bottom: 0, right: kPlaceholderTextViewInsetSpan)
    }

    //MARK: - UIButton Action Methods
    @IBAction func btnBackAction(_ sender: Any) {
    }

    @IBAction func btnAddProfilePicAction(_ sender: Any) {
    }

    @IBAction func btnSignUpAction(_ sender: Any) {
    }
}
