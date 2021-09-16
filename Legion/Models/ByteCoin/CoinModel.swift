//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Evans Owamoyo on 10.08.2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel {
    let price: Double
    let currency: String
    
    var priceString: String {
        String(format: "%.2f", price)
    }
}
