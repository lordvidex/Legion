//
//  FlowerClassiferViewController.swift
//  WhatFlower
//
//  Created by Evans Owamoyo on 19.08.2021.
//

import UIKit
import SDWebImage

class FlowerClassiferViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {
    
    // business logic of this view controller
    var flowerManager = FlowerManager()
    
    // image view that holds the image picked from the library
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    // view controller that opens the user library
    let imagePickerVC: UIImagePickerController = {
        let vc = UIImagePickerController()
        vc.allowsEditing = false
        vc.sourceType = .photoLibrary
        return vc
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePickerVC.delegate = self
        flowerManager.delegate = self
        
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else {
            print("Failed to grab image from image picker")
            return
        }
        imageView.image = image
        flowerManager.analyzeDataFromImage(image)
        picker.dismiss(animated: true, completion: nil)
        
    }

    @IBAction func onCameraClicked(_ sender: Any) {
        present(imagePickerVC, animated: true, completion: nil)
    }
}


// MARK: - App Architecture Notifiers

extension FlowerClassiferViewController: FlowerManagerDelegate {
    func flowerManager(_ manager: FlowerManager, didUpdateFlowerDescription description: String, with newImageURL: String) {
        descriptionLabel.text = description
        if newImageURL != "" {
            imageView.sd_setImage(with: URL(string: newImageURL))
        }
    }
    
    func flowerManager(_ manager: FlowerManager, didUpdateFlowerName name: String,
                       withAccuracy confidence: Float) {
        title = name.capitalized + String(format: " %.0f%%", confidence * 100)
    }
}
