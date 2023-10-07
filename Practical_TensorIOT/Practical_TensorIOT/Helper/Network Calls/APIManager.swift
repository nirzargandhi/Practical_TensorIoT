//
//  APIManager.swift
//  Practical_TensorIOT
//

import FirebaseAuth
import Foundation

//MARK: - API Manager
struct APIManager {

    //MARK: API error enum
    enum APIErrors: Error {

        case invalidURL
        case unableToComplete
        case invalidResponse
        case invalidData
    }

    static func apiFirebaseSignUp(strEmail : String, strPassword : String, completion : @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {

        Auth.auth().createUser(withEmail: strEmail, password: strPassword) { (authResult, error) in

            if error == nil {
                completion(true, authResult, error)
            } else {
                completion(false, authResult, error)
            }
        }
    }

    static func apiFirebaseSignIn(strEmail : String, strPassword : String, completion : @escaping (_ success: Bool, _ object: AnyObject?, _ error: Error?) -> ()) {

        Auth.auth().signIn(withEmail: strEmail, password: strPassword) { (authResult, error) in

            if error == nil {
                completion(true, authResult, error)
            } else {
                completion(false, authResult, error)
            }
        }
    }

    //MARK: API Call Method
    static func apiCall(apiUrl: String, method: String, completionHander: @escaping (Result<Data, APIErrors>) -> Void) {

        let headers = [
            "content-type": "application/json",
            "accept": "application/json"
        ]

        guard let url = URL(string: apiUrl.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!) else {
            completionHander(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: url)
        request.httpMethod = method
        request.allHTTPHeaderFields = headers

        let dataTask = URLSession.shared.dataTask(with: request) { (data, response, error) in

            if let _ = error {
                completionHander(.failure(.unableToComplete))
            }

            guard let response = response as? HTTPURLResponse, response.statusCode == 200 else {
                completionHander(.failure(.invalidResponse))
                return
            }

            guard let data = data else {
                completionHander(.failure(.invalidData))
                return
            }

            completionHander(.success(data))
        }

        dataTask.resume()
    }
}

