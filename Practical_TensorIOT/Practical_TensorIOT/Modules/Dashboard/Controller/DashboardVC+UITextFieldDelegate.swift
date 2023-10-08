//
//  DashboardVC+UITextFieldDelegate.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - UITextField Delegate Extension
extension DashboardVC : UITextFieldDelegate {

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {

        if textField.returnKeyType == UIReturnKeyType.next {
            textField.superview?.superview?.superview?.viewWithTag(textField.tag + 1)?.becomeFirstResponder()
        } else if textField.returnKeyType == UIReturnKeyType.done {
            textField.resignFirstResponder()
        }

        return true
    }

    func textFieldDidEndEditing(_ textField: UITextField) {

        if !txtSearch.isEmpty {
            setWeatherData(search: txtSearch.text ?? "")
        }
    }
}
