//
//  CityTargetType.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

enum CityTargetType: TargetType {
    case getCitys(city: String)
}

extension CityTargetType {
    var parameter: [String : String] {
        switch self {
        case .getCitys(let city):
            return ["q": city]
            
        }
    }
    
    var endPath: String {
        switch self {
        case .getCitys:
            return "AutoCompleteCity"
        }
    }
    
    var basePath: String {
        switch self {
        case .getCitys:
            return "http://gd.geobytes.com/"
        }
    }
}


