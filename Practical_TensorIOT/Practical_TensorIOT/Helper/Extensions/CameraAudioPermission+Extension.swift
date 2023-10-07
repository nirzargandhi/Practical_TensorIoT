//
//  CameraAudioPermission+Extension.swift
//  Practical_TensorIOT
//

import AVFoundation
import UIKit

extension AVCaptureDevice {

    enum AuthorizationStatus {
        case justDenied
        case alreadyDenied
        case restricted
        case justAuthorized
        case alreadyAuthorized
        case unknown
    }

    //MARK: - Authorize Audio Method
    class func authorizeAudio(completion: ((AuthorizationStatus) -> Void)?) {
        AVCaptureDevice.authorize(mediaType: AVMediaType.audio, completion: completion)
    }

    //MARK: - Authorize Video Method
    class func authorizeVideo(completion: ((AuthorizationStatus) -> Void)?) {
        AVCaptureDevice.authorize(mediaType: AVMediaType.video, completion: completion)
    }

    //MARK: - Authorize Method
    private class func authorize(mediaType: AVMediaType, completion: ((AuthorizationStatus) -> Void)?) {

        let status = AVCaptureDevice.authorizationStatus(for: mediaType)

        switch status {

        case .authorized:
            completion?(.alreadyAuthorized)

        case .denied:
            completion?(.alreadyDenied)

        case .restricted:
            completion?(.restricted)

        case .notDetermined:
            AVCaptureDevice.requestAccess(for: mediaType, completionHandler: { (granted) in
                DispatchQueue.main.async {
                    if granted {
                        completion?(.justAuthorized)
                    } else {
                        completion?(.justDenied)
                    }
                }
            })

        @unknown default:
            completion?(.unknown)
        }
    }
}

//MARK: - Microphone Permission Settings Method
func microphonePermissionSettings() {
    let alertController = UIAlertController(title: "Microphone Permission",
                                            message: AppConstants.AlertMessage.msgMicrophonePermission,
                                            preferredStyle: .alert)

    alertController.addAction(UIAlertAction(title: "Cancel", style: .default))

    alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in

        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
        }
    })

    UIApplication.topViewController()?.present(alertController, animated: true)
}

//MARK: - Camera Permission Settings Method
func cameraPermissionSettings() {
    let alertController = UIAlertController(title: "Camera Permission",
                                            message: AppConstants.AlertMessage.msgCameraPermission,
                                            preferredStyle: .alert)

    alertController.addAction(UIAlertAction(title: "Cancel", style: .default))

    alertController.addAction(UIAlertAction(title: "Settings", style: .cancel) { _ in

        guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
            return
        }

        if UIApplication.shared.canOpenURL(settingsUrl) {
            UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
        }
    })

    UIApplication.topViewController()?.present(alertController, animated: true)
}


