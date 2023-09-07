//
//  SearchToDetailRouter.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import UIKit

final class CityToSearchRouter: Router {
   var navigationController: UINavigationController?
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func navigateToRepoView() {
        let searchViewController = SearchViewController.instantiateFromViewController()
        let searchViewModel = DefaultSearchViewModel(_defaultSearchUseCases: DefaultSearchUseCases(networkManeger: NetworkManager.shared()))
        searchViewController.searchViewModel = searchViewModel
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func navigateToWeatherView(with cityName: String) {
        let weatherViewController = WeatherViewController.instantiateFromViewController()
        let ViewModel = DefaultWeatherViewModel(_defaultWeatherUseCases: DefaultWeatherUseCases(), withCity: cityName)
        weatherViewController.weatherViewModel = ViewModel
        self.navigationController?.present(weatherViewController, animated: true)
    }
}
