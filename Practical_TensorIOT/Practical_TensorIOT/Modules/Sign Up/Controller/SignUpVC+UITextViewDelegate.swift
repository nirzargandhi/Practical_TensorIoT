//
//  SignUpVC+UITextViewDelegate.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - UITextView Delegate Extension
extension SignUpVC : UITextViewDelegate {

    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {

        if textView.text.count >= 100 && text.count > 0 {
            return false
        }

        let strTextFieldValue: NSString = (textView.text ?? "") as NSString
        let strText = strTextFieldValue.replacingCharacters(in: range, with: text)
        var isValid = false

        if strText.isEmpty {
            isValid = false
        } else {
            isValid = true
        }

        if isValid {
            btnSignUp.backgroundColor = .appPrimaryColor()

            btnSignUp.isUserInteractionEnabled = true
        } else {
            btnSignUp.backgroundColor = .appGrayColor()

            btnSignUp.isUserInteractionEnabled = false
        }

        return true
    }
}
