//
//  MiddleFasadeLayer.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation

// Main purpose to create this class is to segregate Dore data work from view model like APIusecase.

//Purpose: infuture if we change core data to other database then View model will not effect with this only this onf repo class will chane
protocol CDCityLayerProtocol {
    func saveCity(record: City) -> Bool
    func getAll() -> [City]?
}

struct CDCityCDLayer: CDCityLayerProtocol {
    
    private let cityDataRepository: CityDataRepository
    
    init(cityDataRepository: CityDataRepository) {
        self.cityDataRepository = cityDataRepository
    }
    
    func saveCity(record: City) -> Bool {
        guard record.city.count > 1 else {
            return false
        }
        cityDataRepository.create(record: record)
        return true
    }

    func getAll() -> [City]? {
        return cityDataRepository.getAll()
    }
}
