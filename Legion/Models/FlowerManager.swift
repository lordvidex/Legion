//
//  FlowerManager.swift
//  WhatFlower
//
//  Created by Evans Owamoyo on 19.08.2021.
//

import UIKit

import CoreML
import Vision

import Alamofire
import SwiftyJSON

protocol FlowerManagerDelegate {
    
    /**
     Function called when the flower has just been processed by the CoreML library
    - parameter manager: the flower manager struct
    - parameter name: the name of the new flower gotten from the CoreML predictions
    - parameter confidence: the precison of the prediction
    */
    func flowerManager(_ manager: FlowerManager, didUpdateFlowerName name: String, withAccuracy confidence: Float)
    
    /**
     - parameter manager: the flower manager struct
     - parameter description: the name of the new flower gotten from the CoreML predictions
     - parameter newImageURL: string format of image URL gotten from wikipedia's API  (can be empty string)
     */
    func flowerManager(_ manager: FlowerManager, didUpdateFlowerDescription description: String, with newImageURL: String)
}

struct FlowerManager {
    
    var delegate: FlowerManagerDelegate?
    
    private let wikipediaAPI = "https://en.wikipedia.org/w/api.php"
    
    func analyzeDataFromImage(_ image: UIImage) {
        if let ciImage = CIImage(image: image),
           let model = try? VNCoreMLModel(for: FlowerClassifier(configuration: MLModelConfiguration()).model) {
            let request = VNCoreMLRequest(model: model) { request, error in
                if let e = error {
                    print("Error performing CoreML Request", e)
                }
                guard let results = request.results as? [VNClassificationObservation] else {
                    print("Error casting CoreML request result to VNClassificationObservation")
                    return
                }
                
                let bestResult = results.first!
                
                // notify delegate of name update
                delegate?.flowerManager(self, didUpdateFlowerName: bestResult.identifier, withAccuracy: bestResult.confidence)
                
                // perform api request for description
                getDescription(for: bestResult.identifier)
            }
            let handler = VNImageRequestHandler(ciImage: ciImage)
            do {
                try handler.perform([request])
            }catch {
                print("Error performing request")
            }
            
        }
    }
    
    private func getDescription(for flowerName: String) {
        let params = [
            "format": "json",
            "action": "query",
            "prop": "extracts|pageimages",
            "pithumbsize": "500",
            "exintro": "",
            "explaintext": "",
            "titles": flowerName,
            "indexpageids": "",
            "redirects": "1"
        ]
        AF.request(wikipediaAPI, method: .get, parameters: params).responseJSON { response in
            let json = JSON(try! response.result.get())
            
            let id = json["query"]["pageids"][0].stringValue
            
            let flowerDescription = json["query"]["pages"][id]["extract"].stringValue
            
            let flowerImageURL = json["query"]["pages"][id]["thumbnail"]["source"].stringValue
            
                delegate?.flowerManager(self, didUpdateFlowerDescription: flowerDescription, with: flowerImageURL)
        }
        
    }
}
