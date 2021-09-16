//
//  SeeFoodViewController.swift
//  SeeFood
//
//  Created by Evans Owamoyo on 18.08.2021.
//

import UIKit
import CoreML
import Vision

class SeeFoodViewController: UIViewController,
                      UIImagePickerControllerDelegate,
                      UINavigationControllerDelegate {
    
    @IBOutlet weak var mImageView: UIImageView!
    
    let imagePickerController: UIImagePickerController = {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.allowsEditing = false
        imagePickerVC.sourceType = .photoLibrary
        return imagePickerVC
    }()
    
    let textLabel: UILabel = {
        let label = UILabel()
        label.textColor = .label
        label.text = "Click Camera to scan new Image"
        label.frame = .zero
        label.font = .systemFont(ofSize: 24)
        label.layer.masksToBounds = true
        return label
    }()
    
    override func viewDidLayoutSubviews() {
        textLabel.frame = CGRect(x: 20, y: view.safeAreaInsets.top + 60, width: view.frame.width - 40, height: 50)
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textLabel)
        
        imagePickerController.delegate = self
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let pickedImage = info[.originalImage] as? UIImage else {
            fatalError("Couldn't parse image")
        }
        mImageView.image = pickedImage
        
        if let ciImage = CIImage(image: pickedImage) {
            detect(ciImage)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func onCameraPressed(_ sender: UIBarButtonItem) {
        present(imagePickerController, animated: true, completion: nil)
    }
    
    private func detect(_ ciImage: CIImage) {
        guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
            print("Failed to create model")
            return
        }
        
        let request = VNCoreMLRequest(model: model) { [weak self] request, error in
            guard var results = request.results as? [VNClassificationObservation] else {
                fatalError("Failed to convert results to Array<VNObservation>")
            }
            
            results.sort { $0.confidence > $1.confidence }
                
            self?.textLabel.text = results.first?.identifier
        }
        
        let handler = VNImageRequestHandler(ciImage: ciImage)
        do {
            try handler.perform([request])
        } catch {
            fatalError("Failed to perform Image Requests")
        }
    }
}

