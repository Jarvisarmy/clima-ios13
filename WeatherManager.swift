//
//  WeatherManager.swift
//  Clima
//
//  Created by Jarvis zhang on 2020-09-18.
//  Copyright © 2020 App Brewery. All rights reserved.
//

import Foundation

struct WeatherManager {
    let weatherURL = "https://api.openweathermap.org/data/2.5/weather?appid=f49ff1fc2b09f206606e0ade9c66b048&units=metric"
    func fetchWeather(cityName: String) {
        let urlString = "\(weatherURL)&q=\(cityName)"
        performRequest(urlString: urlString)
    }
    
    func performRequest(urlString: String) {
        // 1. create a URL
        if let url = URL(string: urlString){
            // 2. create a URLSession
            let session = URLSession(configuration: .default)
            // 3. give the session a task
            let task = session.dataTask(with: url, completionHandler: handler(data:response:error:))
            // 4. start the task
            task.resume()
        }
    }
    func handler(data: Data?, response: URLResponse?,error: Error?){
        if (error != nil) {
            print(error!)
            return
        }
        if let safeData = data {
            // let dataString = String(data: safeData, encoding: .utf8)
            self.parseJSON(weatherData: safeData)
        }
    }
    
    func parseJSON(weatherData: Data) {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(WeatherData.self, from: weatherData)
            print(decodedData.weather[0].id)
        } catch {
            print(error)
        }
    }
    
    func getConditionName(weatherId: Int) -> String {
        
    }
}
