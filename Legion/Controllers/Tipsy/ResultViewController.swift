//
//  ResultViewController.swift
//  Tipsy
//
//  Created by Evans Owamoyo on 31.07.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    @IBOutlet weak var eachBillLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    weak var calculatorBrain: TipCalculatorBrain!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        eachBillLabel.text = String(format: "%.2f", calculatorBrain.eachBill ?? 0.0)
        descriptionLabel.text = "Split between \(calculatorBrain.numberOfPersons) people, with \(calculatorBrain.tipPercent) tip."
    }
    
    @IBAction func onRecalculatePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
}
