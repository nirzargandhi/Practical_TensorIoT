//
//  ImageVideoPicker+Extension.swift
//  Practical_TensorIOT
//

import AVFoundation
import Photos
import UIKit

//MARK: - Choose Picture protocol
protocol ChoosePicture {

    func takeAndChoosePhoto()
    func openCamera()
    func openGallery()
}

//MARK: - ChoosePicture Extension
extension ChoosePicture where Self: UIViewController, Self: UIImagePickerControllerDelegate, Self: UINavigationControllerDelegate {

    //MARK: - Take And Choose Photo Method
    func takeAndChoosePhoto() {

        let alert = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        let btnCancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {(action: UIAlertAction) -> Void in
        })

        let btnTakePhoto = UIAlertAction(title: "Take Photo", style: .default, handler: {(action: UIAlertAction) -> Void in
            self.openCamera()
        })

        let btnChooseExisting = UIAlertAction(title: "Choose Photo", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            self.openGallery()
        })

        alert.addAction(btnCancel)
        alert.addAction(btnTakePhoto)
        alert.addAction(btnChooseExisting)

        alert.popoverPresentationController?.sourceView = self.view

        present(alert, animated: true)
    }

    //MARK: - Open Camera Method
    func openCamera() {

        if !UIImagePickerController.isSourceTypeAvailable(.camera) {
            Utility().dynamicToastMessage(strMessage: AppConstants.AlertMessage.msgNoCamera)
        } else {
            let authStatus = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)

            switch authStatus {

            case .authorized:
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen

                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })

            case .denied:
                self.alertPromptToAllowCameraAccessViaSetting()

            default:
                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .camera
                imagePickerController.delegate = self
                imagePickerController.modalPresentationStyle = .overFullScreen
                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }
    }

    //MARK: - Open Gallery Method
    func openGallery() {

        func openImagePickerController() {

            DispatchQueue.main.async {

                let imagePickerController = UIImagePickerController()
                imagePickerController.sourceType = .photoLibrary
                imagePickerController.modalPresentationStyle = .overFullScreen
                imagePickerController.mediaTypes = ["public.image","public.movie"]
                imagePickerController.delegate = self

                self.present(imagePickerController, animated: true, completion: {() -> Void in
                })
            }
        }

        let status = PHPhotoLibrary.authorizationStatus()

        switch status {

        case .authorized:
            openImagePickerController()

        case .denied:
            DispatchQueue.main.async {
                self.alertPromptToAllowPhotoAccessViaSetting()
            }

        default:
            PHPhotoLibrary.requestAuthorization({ (newStatus) in

                if (newStatus == PHAuthorizationStatus.authorized) {
                    openImagePickerController()
                } else {
                    DispatchQueue.main.async {
                        self.alertPromptToAllowPhotoAccessViaSetting()
                    }
                }
            })
        }
    }

    //MARK: - Alert Prompt To Allow Photo & Camer Access Via Setting Methods
    func alertPromptToAllowPhotoAccessViaSetting() {

        let alert = UIAlertController(title: "Permission Alert", message: AppConstants.AlertMessage.msgPhotoLibraryPermission, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .default))

        alert.addAction(UIAlertAction(title: "Setting", style: .cancel) { _ in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        })

        present(alert, animated: true)
    }

    func alertPromptToAllowCameraAccessViaSetting() {

        let alert = UIAlertController(title: "Permission Alert", message: AppConstants.AlertMessage.msgCameraPermission, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: "Cancel", style: .default))

        alert.addAction(UIAlertAction(title: "Setting", style: .cancel) { _ in

            guard let settingsUrl = URL(string: UIApplication.openSettingsURLString) else {
                return
            }

            if UIApplication.shared.canOpenURL(settingsUrl) {
                UIApplication.shared.open(settingsUrl, completionHandler: { (success) in })
            }
        })

        present(alert, animated: true)
    }
}
