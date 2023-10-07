//
//  GlobalVariables.swift
//  Practical_TensorIOT
//

import MBProgressHUD
import UIKit

class GlobalVariables {

    //MARK: - Variable Declaration
    static let shared = GlobalVariables()

    lazy var ScreenWidth = UIScreen.main.bounds.width
    lazy var ScreenHeight = UIScreen.main.bounds.height
    lazy var appDelegate = UIApplication.shared.delegate as? AppDelegate

    lazy var hud : MBProgressHUD = MBProgressHUD()
}
