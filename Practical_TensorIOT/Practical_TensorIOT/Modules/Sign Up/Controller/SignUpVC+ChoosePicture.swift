//
//  SignUpVC+ChoosePicture.swift
//  Practical_TensorIOT
//

import UIKit

//MARK: - UIImagePickerControllerDelegate & ChoosePicture Extension
extension SignUpVC : ChoosePicture, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {

        var newImage : UIImage!

        if let possibleImage = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            newImage = possibleImage
        } else if let possibleImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            newImage = possibleImage
        }

        let orientationFixedImage = fixOrientation(image: newImage)

        imgvProfilePic.image = orientationFixedImage

        if let data = orientationFixedImage.jpegData(compressionQuality: 0.5) {
            dataProfilePic = data
        }

        picker.dismiss(animated: true)
    }

    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }

    func fixOrientation(image : UIImage) -> UIImage {

        if image.imageOrientation == UIImage.Orientation.up {
            return image
        }

        UIGraphicsBeginImageContextWithOptions(image.size, false, image.scale)
        image.draw(in: CGRect(x: 0, y: 0, width: image.size.width, height: image.size.height))

        if let normalizedImage: UIImage = UIGraphicsGetImageFromCurrentImageContext() {
            UIGraphicsEndImageContext()
            return normalizedImage
        } else {
            return image
        }
    }
}

