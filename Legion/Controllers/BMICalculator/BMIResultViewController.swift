//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Evans Owamoyo on 29.07.2021.
//  Copyright © 2021 Angela Yu. All rights reserved.
//

import UIKit

class BMIResultViewController: UIViewController {
    var bmiValue: String?
    var bmiColor: UIColor?
    var bmiAdvice: String?
    
    @IBOutlet weak var bmiValueLabel: UILabel!
    @IBOutlet weak var bmiAdviceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiValueLabel.text = bmiValue
        view.backgroundColor = bmiColor
        bmiAdviceLabel.text = bmiAdvice
        
    }

    @IBAction func onRecalculatePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
