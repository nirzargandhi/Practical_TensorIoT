//
//  DashboardVC.swift
//  Practical_TensorIOT
//

import SDWebImage
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

    //MARK: - Variable Declaration
    lazy var objDashboardViewModel = DashboardViewModel()
    var dictUserData : NSDictionary?

    //MARK: - ViewController Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        initialization()

        setUserData()

        setWeatherData(search: "Kolkata", isLoader: false)
    }

    //MARK: - Initialization Method
    private func initialization() {
        hideNavigationBar(isTabbar: false)
    }

    //MARK: - UIButton Action Method
    @IBAction func btnLogoutAction(_ sender: Any) {

        let actionController: UIAlertController = UIAlertController(title: AppConstants.AlertMessage.msgLogoutTitle, message: AppConstants.AlertMessage.msgLogoutDescription, preferredStyle: .alert)

        let logoutAction : UIAlertAction = UIAlertAction(title: "Log Out", style: .cancel) {_ in
            UserDefault().userDefaultKeyChainDataClear()

            GlobalVariables.shared.appDelegate?.setRootSignInVC()
        }

        let goBackAction : UIAlertAction = UIAlertAction(title: "Go Back", style: .default) { action -> Void in }

        actionController.addAction(logoutAction)
        actionController.addAction(goBackAction)

        present(actionController, animated: true)
    }

    //MARK: - Set User Data Method
    private func setUserData() {

        objDashboardViewModel.getUserData() { [weak self] success, responseData  in

            guard let self else { return }

            if success, let dictUserDetails = responseData {
                imgvProfilePic.sd_setImage(with: URL(string: dictUserDetails.value(forKey: "imgProfilePic") as? String ?? ""), placeholderImage: UIImage(named: "ic_profile")?.withTintColor(.appPrimaryColor()))

                lblFullname.text = dictUserDetails.value(forKey: "fullname") as? String ?? ""

                lblEmailId.text = dictUserDetails.value(forKey: "emailId") as? String ?? ""

                lblBio.text = dictUserDetails.value(forKey: "bio") as? String ?? ""
            } else {
                imgvProfilePic.image = UIImage(named: "ic_profile")

                lblFullname.text = ""
                lblEmailId.text = ""
                lblBio.text = ""
            }
        }
    }

    //MARK: - Set Weather Data Method
    internal func setWeatherData(search: String, isLoader: Bool = true) {

        objDashboardViewModel.callWeatherAPI(strSearch: search, isLoader: isLoader) { [weak self] success, responseData  in

            guard let self else { return }

            if success, let dictResponseData = responseData {
                let dictWeather = (dictResponseData.weather?.count ?? 0) > 0 ? dictResponseData.weather?[0] : nil

                lblCity.text = dictResponseData.name ?? ""

                imgvIcon.sd_setImage(with: URL(string: "\(AppConstants.WebServiceURL.iconURL)\(dictWeather?.icon ?? "")@2x.png"))

                let currentDateTime = Date(timeIntervalSinceNow: TimeInterval(dictResponseData.timezone ?? 0))
                lblTime.text = Utility().datetimeFormatter(strFormat: AppConstants.DateAndTimeFormatString.strDateFormate_hhmma, isTimeZoneUTC: true).string(from: currentDateTime)

                lblCurrentTemp.text = "\(dictResponseData.main?.temp ?? 0.0) C"

                lblHighLowTemp.text = "\(dictResponseData.main?.temp_max ?? 0.0) C" + " | " + "\(dictResponseData.main?.temp_min ?? 0.0) C"

                lblWeather.text = dictWeather?.main ?? ""

                lblHumidity.text = "\(dictResponseData.main?.humidity ?? 0) %"

                lblWindSpeed.text = "\(dictResponseData.wind?.speed ?? 0.0) meter/sec"

                let sunriseDateTime = Date(timeIntervalSince1970: TimeInterval(dictResponseData.sys?.sunrise ?? 0))
                lblSunriseTime.text = Utility().datetimeFormatter(strFormat: AppConstants.DateAndTimeFormatString.strDateFormate_hhmma, isTimeZoneUTC: false).string(from: sunriseDateTime)

                let sunsetDateTime = Date(timeIntervalSince1970: TimeInterval(dictResponseData.sys?.sunset ?? 0))
                lblSunsetTime.text = Utility().datetimeFormatter(strFormat: AppConstants.DateAndTimeFormatString.strDateFormate_hhmma, isTimeZoneUTC: false).string(from: sunsetDateTime)

                vWeather.isHidden = false
                lblNoWeatherData.isHidden = true
            } else {
                imgvIcon.image = nil

                lblCity.text = ""
                lblTime.text = ""
                lblCurrentTemp.text = ""
                lblHighLowTemp.text = ""
                lblWeather.text = ""
                lblHumidity.text = ""
                lblWindSpeed.text = ""
                lblSunriseTime.text = ""
                lblSunsetTime.text = ""

                lblNoWeatherData.isHidden = false
                vWeather.isHidden = true
            }
        }
    }
}
