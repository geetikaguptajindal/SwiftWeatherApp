//
//  CDCityTestMock.swift
//  SwiftWeatherAppTests
//
//  Created by Geetika Gupta on 08/09/23.
//

import XCTest
@testable import SwiftWeatherApp

final class CityDataRepositoryMock : CDCityLayerProtocol {
    
    var dataSave: Int = 0
    var dataFetch: Int = 0
        
    func saveCity(record: City) -> Bool {
        XCTAssertNotNil(record)
        dataSave += 1
        return true
    }

    func getAll() -> [City]? {
        if dataSave > 0 {
            dataFetch += 1
            return [City(city: "Vienna", country: "Austria")]
        }
        return []
    }
    
    func get(byIdentifier id: UUID) -> SwiftWeatherApp.City? {
        nil
    }
}
