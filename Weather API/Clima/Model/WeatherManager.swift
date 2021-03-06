//
//  WeatherManager.swift
//  Clima
//
//  Created by Alexandru Bardea on 05/03/2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
struct WeatherManager {
    let weatherURL = "http://api.openweathermap.org/data/2.5/weather?appid=ddad6763cc1ea30d42f9c82e33a6bf15&units=metric"

    func fetchWeather(cityName: string){
        let urlString = "\(weatherURL)&q=\(cityName)"
        
    }

}
