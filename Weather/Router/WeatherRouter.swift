//
//  WeatherRouter.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation

final class WeatherRouter: Router {
    var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
}
