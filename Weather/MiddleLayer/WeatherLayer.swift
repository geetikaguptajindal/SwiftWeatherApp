//
//  WeatherLayerProtocol.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation

protocol CDWeatherLayerProtocol {
    func save(record: WeatherLocalData) -> Bool
    func getAll(withCityUUID id: UUID) -> [WeatherLocalData]?
}

struct WeatherLayer: CDWeatherLayerProtocol {
    private let weatherRepository: WeatherRepository
    
    init(weatherRepository: WeatherRepository) {
        self.weatherRepository = weatherRepository
    }
    
    func save(record: WeatherLocalData) -> Bool {
        guard let _ = record.cityObj  else {
            return false
        }
        
        weatherRepository.create(record: record)
        return true
    }
    
    func getAll(withCityUUID id: UUID) -> [WeatherLocalData]? {
        weatherRepository.getWeatherForCity(byIdentifier: id)
    }
    
    
    
    
    
}

