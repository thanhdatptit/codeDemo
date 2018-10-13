//
//  ImageCameraViewController.swift
//  ScrollViewDemo
//
//  Created by NTQ on 10/8/18.
//  Copyright © 2018 NguyenManh. All rights reserved.
//

import UIKit

protocol ImageCameraViewControllerDelegate:class {
    func imageCameraView (_ viewcontroller:ImageCameraViewController, selectImage image:UIImage)
}

class ImageCameraViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    weak var delegate:ImageCameraViewControllerDelegate?

    @IBOutlet weak var cameraImage: UIButton!
    @IBOutlet weak var libraryImage: UIButton!
    let imagePickerController = UIImagePickerController()
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerController.delegate = self
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        cameraImage.layer.cornerRadius = 7
        libraryImage.layer.cornerRadius = 7
    }

    @IBAction func camera(_ sender: Any) {
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            imagePickerController.sourceType = .camera
            self.present(imagePickerController, animated: true, completion: nil)
        } else {
            print("Camera not available")
        }

    }

    @IBAction func libraly(_ sender: Any) {
        imagePickerController.sourceType = .photoLibrary
        self.present(imagePickerController, animated: true, completion: nil)
    }

    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let image1 = info[UIImagePickerControllerOriginalImage] as! UIImage
        delegate?.imageCameraView(self, selectImage: image1)

        picker.dismiss(animated: true, completion: nil)
    }
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)

    }

}
