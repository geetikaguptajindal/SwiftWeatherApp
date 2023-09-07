//
//  WeatherResponse.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

struct WeatherResponse: Codable {
    let main: WeatherData
    let wind: Wind
    let weather: [Weather]
    let name: String
}

struct WeatherData: Codable {
    let temp: Double
    let humidity: Double
}

// MARK: - Wind
struct Wind: Codable {
    let speed: Double
}

struct Weather: Codable {
    let weatherDescription: String
    let icon: String
    
    enum CodingKeys: String, CodingKey {
        case weatherDescription = "description"
        case icon
    }
}

// convert server response model into local model
extension WeatherResponse {
    func intoWeatherLocalData() -> WeatherLocalData {
        WeatherLocalData(temp: self.main.temp, speed: self.wind.speed, humidity: self.main.humidity,description: self.weather.first?.weatherDescription ?? "", icon: self.weather.first?.icon ?? "")
    }
}

struct WeatherLocalData {
    var temp: Double
    let speed: Double
    let humidity: Double
    let description: String
    let icon: String

    var formattedTemprature: String {
        "\(temp)".appending("˚C")
    }
    
    var formattedHumidity: String {
        "\(humidity)".appending("%")
    }
    
    var formattedWindSpeed: String {
        "\(speed)"
    }
}


