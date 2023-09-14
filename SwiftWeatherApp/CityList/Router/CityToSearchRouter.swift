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
        let searchViewModel = DefaultSearchViewModel(_defaultSearchUseCases: DefaultSearchUseCases(networkManeger: NetworkManager.shared()), withCDManager: CDCityCDLayer(cityDataRepository: CityDataRepository()))
        
        searchViewController.searchViewModel = searchViewModel
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
    
    func navigateToWeatherView(with cityObj: City) {
        let weatherViewController = WeatherViewController.instantiateFromViewController()

        let ViewModel = DefaultWeatherViewModel(_defaultWeatherUseCases: DefaultWeatherUseCases(with: cityObj), withCity: cityObj, weatherLayer: WeatherLayer(weatherRepository: WeatherRepository()))
        weatherViewController.weatherViewModel = ViewModel
        
        // router
        let router = WeatherRouter(navigationController: self.navigationController ?? UINavigationController())
        weatherViewController.router = router
        self.navigationController?.present(weatherViewController, animated: true)
    }
    
    func routingFromWeatherToHistoricalDataView(with cityObj: City) {
        let weatherViewController = HistoricalWeatherDataViewController.instantiateFromViewController()
        let ViewModel = DefaultHistoricalWeatherViewModel(weatherLayer: WeatherLayer(weatherRepository: WeatherRepository()), cityObj: cityObj)
        weatherViewController.weatherViewModel = ViewModel
        self.navigationController?.present(weatherViewController, animated: true)
    }
}
