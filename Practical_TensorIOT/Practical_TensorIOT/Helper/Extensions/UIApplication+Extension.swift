//
//  UIApplication+Extension.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - UIApplication Extension
extension UIApplication {

    //MARK: - Top ViewController Method
    public class func topViewController(_ base: UIViewController? = UIApplication.shared.windows.first(where: { $0.isKeyWindow })?.rootViewController) -> UIViewController? {

        if let nav = base as? UINavigationController {
            return topViewController(nav.visibleViewController)
        }

        if let tab = base as? UITabBarController {
            if let selected = tab.selectedViewController {
                return topViewController(selected)
            }
        }

        if let presented = base?.presentedViewController {
            return topViewController(presented)
        }

        return base
    }
}
