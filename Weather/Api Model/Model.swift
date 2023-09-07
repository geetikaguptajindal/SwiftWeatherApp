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
    let description: String
}


extension WeatherResponse {
    func intoWeatherLocalData() -> WeatherLocalData {
        WeatherLocalData(temp: self.main.temp, speed: self.wind.speed, humidity: self.main.humidity, name: self.name)
    }
}

struct WeatherLocalData {
    let temp: Double
    let speed: Double
    let humidity: Double
    let name: String
}


