//
//  UITextField+Extension.swift
//  Practical_TensorIOT
//

import UIKit

private var kAssociationKeyMaxLength: Int = 0
private let nameRegex = "^(?=.{2,130}$)[A-Za-zÀ-ú][A-Za-zÀ-ú.'-]+(?: [A-Za-zÀ-ú.'-]+)* *$"
private let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
private let passwordRegex = "^(?=.{8,})(?=.*[a-z])(?=.*[A-Z]).*$"

//MARK: - UITextField Extension
extension UITextField {

    @IBInspectable var maxLength: Int {
        get {
            if let length = objc_getAssociatedObject(self, &kAssociationKeyMaxLength) as? Int {
                return length
            } else {
                return Int.max
            }
        }
        set {
            objc_setAssociatedObject(self, &kAssociationKeyMaxLength, newValue, .OBJC_ASSOCIATION_RETAIN)
            addTarget(self, action: #selector(checkMaxLength), for: .editingChanged)
        }
    }

    @IBInspectable var paddingLeftView: CGFloat {
        get {
            return self.leftView?.frame.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            leftView = paddingView
            leftViewMode = .always
        }
    }

    @IBInspectable var paddingRightView: CGFloat {
        get {
            return self.leftView?.frame.width ?? 0
        }
        set {
            let paddingView = UIView(frame: CGRect(x: 0, y: 0, width: newValue, height: frame.size.height))
            rightView = paddingView
            rightViewMode = .always
        }
    }
    @IBInspectable var placeHolderColor: UIColor? {
        get {
            return self.placeHolderColor
        }
        set {
            self.attributedPlaceholder = NSAttributedString(string:self.placeholder != nil ? self.placeholder! : "", attributes:[NSAttributedString.Key.foregroundColor: newValue!])
        }
    }

    //MARK: - Check Validations
    var isEmpty: Bool {
        return trimmedText?.isEmpty == true
    }

    var trimmedText: String? {
        return text?.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    func validateName() -> Bool {
        let nameCheck = NSPredicate(format:"SELF MATCHES %@", nameRegex)
        return nameCheck.evaluate(with: self.text)
    }

    func validateEmail() -> Bool {
        let emailCheck = NSPredicate(format:"SELF MATCHES %@", emailRegex)
        return emailCheck.evaluate(with: self.text)
    }

    func validatePassword() -> Bool {
        let passwordCheck = NSPredicate(format:"SELF MATCHES %@", passwordRegex)
        return passwordCheck.evaluate(with: self.text)
    }

    func checkMinAndMaxLength(withMinLimit minLen: Int, withMaxLimit maxLen: Int) -> Bool {
        if (self.text!.count ) >= minLen && (self.text!.count ) <= maxLen {
            return true
        }
        return false
    }

    @objc func checkMaxLength(textField: UITextField) {

        guard let prospectiveText = self.text,
              prospectiveText.count > maxLength
        else {
            return
        }

        let selection = selectedTextRange
        let maxCharIndex = prospectiveText.index(prospectiveText.startIndex, offsetBy: maxLength)
        text = String(prospectiveText.prefix(upTo: maxCharIndex))
        selectedTextRange = selection
    }
}
