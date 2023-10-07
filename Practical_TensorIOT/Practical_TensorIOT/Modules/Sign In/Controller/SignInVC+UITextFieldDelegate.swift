//
//  SignInVC+UITextFieldDelegate.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - UITextField Delegate Extension
extension SignInVC : UITextFieldDelegate {

    func textFieldDidBeginEditing(_ textField: UITextField) {
        hideValidMessage()
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()

            btnSignInAction(textField)
        }

        return true
    }

    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

        let strTextFieldValue: NSString = (textField.text ?? "") as NSString
        let strText = strTextFieldValue.replacingCharacters(in: range, with: string)
        var isValid = false

        if strText.isEmpty {
            isValid = false
        } else {
            isValid = true
        }

        if isValid {
            btnSignIn.backgroundColor = .appPrimaryColor()

            btnSignIn.isUserInteractionEnabled = true
        } else {
            btnSignIn.backgroundColor = .appGrayColor()

            btnSignIn.isUserInteractionEnabled = false
        }

        return true
    }
}
