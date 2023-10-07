//
//  DashboardVC.swift
//  Practical_TensorIOT
//

import UIKit

class DashboardVC: UIViewController {

    //MARK: - UIScrollView Outlet
    @IBOutlet weak var scrollView: UIScrollView!

    //MARK: - UIView Outlets
    @IBOutlet weak var vMain: UIView!
    @IBOutlet weak var vWeather: UIView!

    //MARK: - UIImageView Outlets
    @IBOutlet weak var imgvProfilePic: UIImageView!
    @IBOutlet weak var imgvIcon: UIImageView!

    //MARK: - UITextField Outlet
    @IBOutlet weak var txtSearch: UITextField!

    //MARK: - UILabel Outlets
    @IBOutlet weak var lblFullname: UILabel!
    @IBOutlet weak var lblEmailId: UILabel!
    @IBOutlet weak var lblBio: UILabel!
    @IBOutlet weak var lblCity: UILabel!
    @IBOutlet weak var lblTime: UILabel!
    @IBOutlet weak var lblCurrentTemp: UILabel!
    @IBOutlet weak var lblHighLowTemp: UILabel!
    @IBOutlet weak var lblWeather: UILabel!
    @IBOutlet weak var lblHumidity: UILabel!
    @IBOutlet weak var lblWindSpeed: UILabel!
    @IBOutlet weak var lblSunriseTime: UILabel!
    @IBOutlet weak var lblSunsetTime: UILabel!
    @IBOutlet weak var lblNoWeatherData: UILabel!

    //MARK: - ViewController Method
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()
    }

    //MARK: - Initialization Method
    private func initialization() {
        hideNavigationBar(isTabbar: false)
    }

    //MARK: - UIButton Action Method
    @IBAction func btnLogoutAction(_ sender: Any) {
    }
}
