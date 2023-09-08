//
//  App Router.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 06/09/23.
//
import UIKit

final class AppRouter: Router {    
   var navigationController: UINavigationController?
    
    private let window: UIWindow
    
    init(window: UIWindow) {
        self.window = window
    }
    
    func appStart() {
        let cityViewController = CityViewController.instantiateFromViewController()
        let naviationController = UINavigationController(rootViewController: cityViewController)
        
        // ViewModel
        let viewModel = DefaultCityViewModel(withCDManager: CDCityCDLayer(cityDataRepository: CityDataRepository()))
        cityViewController.cityViewModel = viewModel
                                                        
        //router
        cityViewController.router = CityToSearchRouter.init(navigationController: naviationController)
        window.rootViewController = naviationController
    }
}
