//
//  WeatherManager.swift
//  Clima
//
//  Created by Evans Owamoyo on 10.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//
import Foundation
import CoreLocation

protocol WeatherManagerDelegate {
    func didFailWithError(error: Error?)
    func didUpdateWeather(_ weatherManager: WeatherManager, weather: WeatherModel)
}


struct WeatherManager {
    
    var delegate: WeatherManagerDelegate?
    
    let weatherAPI = "https://api.openweathermap.org/data/2.5/weather?appid=e2c7fed39431cd283f12f0c2820fe47f&units=metric"
    
    func fetchWeather(cityName: String) {
        let apiString = "\(weatherAPI)&q=\(cityName)"
        performRequest(apiString)
    }
    
    func fetchWeather(lon: CLLocationDegrees, lat: CLLocationDegrees) {
        let apiString = "\(weatherAPI)&lat=\(lat)&lon=\(lon)"
        performRequest(apiString)
    }
    
    private func performRequest(_ apiString: String) {
        if let url = URL(string: apiString) {
            
            let session = URLSession(configuration: .default)
            
            let task = session.dataTask(with: url) { data, response, error in
                if error != nil {
                    delegate?.didFailWithError(error: error)
                    return
                }
                
                do {
                    let decoder = JSONDecoder()
                    let weatherData = try decoder.decode(WeatherData.self, from: data!)
                    
                    let model = WeatherModel(cityName: weatherData.name,
                                             conditionId: weatherData.weather[0].id,
                                             temperature: weatherData.main.temp)
                    delegate?.didUpdateWeather(self, weather: model)
                } catch {
                    delegate?.didFailWithError(error: error)
                }
            }
            
            task.resume()
            
        }
    }
}

