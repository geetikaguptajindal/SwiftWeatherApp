//
//  City.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

struct City: Decodable {
    let id: UUID
    let city: String
    let country: String
}
