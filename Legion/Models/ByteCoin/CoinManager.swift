//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import Foundation

protocol CoinManagerDelegate {
    
    func didUpdatePrice(_ manager: CoinManager, coinModel: CoinModel)
    func didFailWithError(error: Error?)
}


struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "957E4885-8537-4EA2-971E-0FF62B14FCCC"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]
    
    
    var delegate: CoinManagerDelegate?
    
    func getPrice(for currency: String) {
        
        let urlString = "\(baseURL)/\(currency)"
        performRequest(urlString)
        
    }
    
    func performRequest(_ urlString: String){
        if let url = URL(string: urlString) {
            var request = URLRequest(url: url)
            request.addValue(apiKey, forHTTPHeaderField: "X-CoinAPI-Key")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let e = error {
                    // catching network errors
                    delegate?.didFailWithError(error: e)
                } else {
                    do{
                        let decoder = JSONDecoder()
                        decoder.keyDecodingStrategy = .convertFromSnakeCase
                        let coinData = try decoder.decode(CoinData.self, from: data!)
                        let coinModel = CoinModel(price: coinData.rate, currency: coinData.assetIdQuote)
                        
                        delegate?.didUpdatePrice(self,coinModel: coinModel)
                        
                    } catch {
                        delegate?.didFailWithError(error: error)
                    }
                }
            }
            
            task.resume()
        }
        
    }
}
