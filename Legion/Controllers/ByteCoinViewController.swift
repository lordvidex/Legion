//
//  ByteCoinViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ByteCoinViewController: UIViewController {
    
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.delegate = self
        currencyPicker.dataSource = self
        coinManager.delegate = self
    }
    
    
}


// MARK: - UIPickerViewDelegate


extension ByteCoinViewController: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getPrice(for: selectedCurrency)
    }
    
}

// MARK: - UIPickerViewDataSource


extension ByteCoinViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        coinManager.currencyArray.count
    }
    
}

// MARK: - CoinManagerDelegate

extension ByteCoinViewController: CoinManagerDelegate {
    func didUpdatePrice(_ manager: CoinManager, coinModel: CoinModel) {
        DispatchQueue.main.async {
            self.priceLabel.text = coinModel.priceString
            self.currencyLabel.text = coinModel.currency
        }
    }
    
    func didFailWithError(error: Error?) {
        let alert = UIAlertController(title: "Error", message: "Failed to get price from the internet, try again later!", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        DispatchQueue.main.async {
            self.show(alert, sender: self)
        }
    }
    
    
}

