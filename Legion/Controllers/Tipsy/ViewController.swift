//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var billTextField: UITextField!
    @IBOutlet weak var splitLabel: UILabel!
    @IBOutlet weak var splitStepper: UIStepper!
    @IBOutlet weak var zeroPercentBtn: UIButton!
    @IBOutlet weak var tenPercentBtn: UIButton!
    @IBOutlet weak var twentyPercentBtn: UIButton!
    
    var currentTipPercent = "10%"
    var calculatorBrain = TipCalculatorBrain.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()

        splitLabel.text = String(format: "%.0f", splitStepper.value)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showResult" {
            let resultVC = segue.destination as! ResultViewController
            resultVC.calculatorBrain = calculatorBrain
        }
    }
    @IBAction func onTipSelected(_ sender: UIButton) {
        // remove focus from billTextField
        billTextField.endEditing(true)
        
        currentTipPercent = sender.currentTitle!
        
        updateButtons()
    }
    
    
    @IBAction func onStepperClicked(_ sender: UIStepper) {
        splitLabel.text = String(format: "%.0f", splitStepper.value)
    }
    
    
    @IBAction func onCalculateClicked(_ sender: Any) {
        calculatorBrain.calculateEachBill(from: Double(billTextField.text!)!,
                                          within: Int(splitStepper.value),
                                          withTip: currentTipPercent)
        
        performSegue(withIdentifier: "showResult", sender: self)
    }
    
    
    func updateButtons() {
        updateBtnColor(zeroPercentBtn)
        updateBtnColor(tenPercentBtn)
        updateBtnColor(twentyPercentBtn)
    }
    
    func updateBtnColor(_ button: UIButton) {
        if button.currentTitle == currentTipPercent {
            button.isSelected = true
        } else {
            button.isSelected = false
        }
    }
}

