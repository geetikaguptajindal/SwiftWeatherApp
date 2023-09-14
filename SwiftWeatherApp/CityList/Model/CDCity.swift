//
//  CDCIty.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation

extension CDCity {
    
    func convertToCity() -> City? {
        guard let cityName = self.name, let id = self.id else {
            return nil
        }
        return City(id: id, city: cityName, country: self.country ?? "")
    }
}


extension CDWeather {
    
    func convertToWeather() -> WeatherLocalData? {
        guard let weather = self.wDescription, let timeStamp = self.timeStamp else {
            return nil
        }
        return WeatherLocalData(temp: self.temp, speed: self.wind, humidity: self.humidity, description: weather, icon: "", fetchTimeStamp: timeStamp)
    }
}
