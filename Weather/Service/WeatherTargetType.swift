//
//  searchTargetType.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

enum WeatherTargetType: TargetType {
    case getCityWeather(city: String)
}

extension WeatherTargetType {
    
    var parameter: [String : String] {
        switch self {
        case .getCityWeather(let city):
            return [
                "q": city,
                "appid": WeatherConstant.apiKey.rawValue,
                "units":"metric"
            ]
        }
    }
    
    var endPath: String {
        switch self {
        case .getCityWeather:
            return "weather"
        }
    }
    
    var basePath: String {
        switch self {
        case .getCityWeather:
            return "https://api.openweathermap.org/data/2.5/"
        }
    }
}


