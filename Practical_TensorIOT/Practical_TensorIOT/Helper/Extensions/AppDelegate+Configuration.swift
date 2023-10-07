//
//  AppDelegate+Configuration.swift
//  Practical_TensorIOT
//

//MARK: - AppDelegate Extension
extension AppDelegate {

    //MARK: - Config App Method
    func configApp() {

        setRootController()
    }

    //MARK: - Set Root Controller Method
    func setRootController() {
        Utility().setRootSignInVC()
    }
}

