//
//  CDCIty.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation

extension CDCity {
    
    func convertToCity() -> City? {
        guard let cityName = self.name else {
            return nil
        }
        return City(city: cityName, country: self.country ?? "")
    }
}
