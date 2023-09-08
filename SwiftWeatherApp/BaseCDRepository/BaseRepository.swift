//
//  BaseRepository.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation

// Make generic protocol for core data CRUD operation
protocol BaseRepository {
    associatedtype T

    func create(record: T)
    func getAll() -> [T]?
    
    // this is for weather record as per city id
    func get(byIdentifier id: UUID) -> T?
}
