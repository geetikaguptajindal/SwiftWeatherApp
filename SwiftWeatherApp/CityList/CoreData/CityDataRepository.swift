//
//  CityDataRepository.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation
import CoreData

struct CityDataRepository : BaseRepository {
    typealias T = City
    
    func create(record: City) {
        let cdCity = CDCity(context: PersistentStorage.shared.context)
        cdCity.id = UUID()
        cdCity.name = record.city
        cdCity.country = record.country
        
        PersistentStorage.shared.saveContext()
    }

    func getAll() -> [City]? {
        let records = PersistentStorage.shared.fetchManagedObject(managedObject: CDCity.self)
        guard let cityRecords = records, !cityRecords.isEmpty else {return nil}

        var results: [City] = []
        cityRecords.forEach({ (cdCity) in
            if let cityModel = cdCity.convertToCity() { // convert cdmodel to appModel
                results.append(cityModel)
            }
        })
        return results
    }
    
    func get(byIdentifier id: UUID) -> City? {
        return nil
    }
}
