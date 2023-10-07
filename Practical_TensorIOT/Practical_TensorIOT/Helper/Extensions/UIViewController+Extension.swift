//
//  UIViewController+Extension.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - UIViewController Extension
extension UIViewController {

    //MARK: - Hide Navigation Bar Method
    func hideNavigationBar(isTabbar : Bool = true) {
        if isTabbar {
            self.tabBarController?.navigationController?.setNavigationBarHidden(true, animated: false)
        } else {
            self.navigationController?.setNavigationBarHidden(true, animated: false)
        }
    }
}

