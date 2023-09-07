//
//  AppConstant.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation


enum WeatherConstant: String {
    case apiKey = "f5cb0b965ea1564c50c6f1b74534d823"
}

enum StringConstant {
    static let invalidURL = "Url is invalid"
    static let decodeError = "Decoding Error"
    static let city = "CITIES"
    static let add = "Add"
    static let enterCityName = "Enter City Name"
    static let cityAddAlertTitle = " Are you sure you want to add"
    static let cancel = "Cancel"

}


enum CellIdentifier {
    static let mainCityList = "MainCityCell"
    static let searchCityList = "CityCell"

}
