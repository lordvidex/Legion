//
//  TipCalculatorBrain.swift
//  Tipsy
//
//  Created by Evans Owamoyo on 30.07.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import UIKit

class TipCalculatorBrain {
    
    // MARK: singleton instance to be used between first and result screens
    static let shared = TipCalculatorBrain()
    
    var eachBill: Double?
    var numberOfPersons: Int = 2
    var tipPercent: String = "0%"
    
    /// - Parameters:
    ///   - totalBill: The total bill to be shared among people
    ///   - numberOfPersons: The number of people sharing this amount
    ///   - withTip: the tip amount that is not shared among them
    /// - Returns: The amount for each person
    func calculateEachBill(from totalBill: Double,
                           within numberOfPersons: Int,
                           withTip tipPercent: String = "0%") {
        self.numberOfPersons = numberOfPersons
        self.tipPercent = tipPercent
        
        let discounted = totalBill * (1 - tipFromString(tipPercent))
        eachBill = discounted / Double(numberOfPersons)
    }
    
    func tipFromString(_ tipString: String) -> Double {
        var string =
        tipString.trimmingCharacters(in: .whitespacesAndNewlines)
            
            string.removeAll { char in
            char == "%"
            }
        return Double(string)! / Double(100)
    }
}
