//
//  searchTargetType.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

enum WeatherTargetType: TargetType {
    case getCityWeather(city: String)
    case getImage(icon: String)
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
            
        case .getImage:
            return [:]
        }
    }
    
    var endPath: String {
        switch self {
        case .getCityWeather:
            return "data/2.5/weather"
            
        case .getImage:
            return "img/wn/"
        }
    }
    
    var basePath: String {
        switch self {
        case .getCityWeather:
            return "https://api.openweathermap.org/"
           
        case .getImage:
            return "https://openweathermap.org/"
        }
    }
}


