//
//  DashboardViewModel.swift
//  Practical_TensorIOT
//

import Foundation
import FirebaseDatabase

class DashboardViewModel {

    //MARK: - Variable Declaration
    var dictUserData: NSDictionary?
    var dictWeather : WeatherModel?

    //MARK: - Get User Data Method
    internal func getUserData(completion: @escaping (_ success: Bool, _ object: NSDictionary?) -> ()) {

        guard case NetworkCheck.isConnectedToNetwork() = true else {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgNetworkConnection)
            return
        }

        if let strUserId = UserDefault().getUserDefault(AppConstants.UserDefaultKeys.kUserId) {

            Utility().showLoader()

            Database.database().reference().child(AppConstants.Firebase.databaseUser).child("\(strUserId)").getData(completion:  { error, snapshot in

                Utility().hideLoader()

                guard error == nil else {

                    Utility().dynamicToastMessage(strMessage: error?.localizedDescription ?? AppConstants.AlertMessage.msgError)

                    completion(false, nil)

                    return
                }

                completion(true, snapshot?.value as? NSDictionary)
            })
        }
    }

    //MARK: - Call Weather API Method
    internal func callWeatherAPI(strSearch: String, isLoader: Bool, completion: @escaping (_ success: Bool, _ object: WeatherModel?) -> ()) {

        guard case NetworkCheck.isConnectedToNetwork() = true else {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgNetworkConnection)
            return
        }

        if isLoader {
            Utility().showLoader()
        }

        let strURL = "\(AppConstants.WebServiceURL.weatherURL)\(AppConstants.WebServiceParameter.pSearch)=\(strSearch)&\(AppConstants.WebServiceParameter.pUnits)=metric&\(AppConstants.WebServiceParameter.pAppId)=\(AppConstants.OpenWeather.pAPIKey)"

        let params = [String : Any]()

        APIManager.apiCall(apiUrl: strURL, method: AppConstants.APIMethodType.kPost, requestPARAMS: params) { [weak self] result in

            if isLoader {
                Utility().hideLoader()
            }

            guard let self else { return }

            DispatchQueue.main.async {

                switch result {

                case .success(let data):
                    let decoder = JSONDecoder()
                    do {
                        if let convertedJsonIntoDict = try JSONSerialization.jsonObject(with: data, options: []) as? NSDictionary {
                            print(convertedJsonIntoDict)
                        }

                        self.dictWeather = try decoder.decode(WeatherModel.self, from: data)

                        completion(true, self.dictWeather)
                    } catch let error as NSError {

                        print("\n\n===========Error===========")
                        print("Error Code: \(error._code)")
                        print("Error Messsage: \(error.localizedDescription)")
                        if let str = String(data: data, encoding: String.Encoding.utf8) {
                            print("Print Server data:- " + str)
                        }
                        print(error)
                        print("===========================\n\n")

                        completion(false, nil)
                    }
                case .failure(let error):

                    switch error {

                    case .invalidURL:
                        Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgInvalidUrlMessage)

                    case .invalidResponse:
                        Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgInvalidResponseMessage)

                    case .unableToComplete:
                        Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgUnableToCompleteMessage)

                    case .invalidData:
                        Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgInvalidDataMessage)

                    default:
                        break
                    }

                    completion(false, nil)
                }
            }
        }
    }
}
