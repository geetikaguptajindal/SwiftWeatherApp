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
        let viewController = CityViewController.instantiateFromViewController()
        let naviationController = UINavigationController(rootViewController: viewController)
        
        //router
        viewController.router = CityToSearchRouter.init(navigationController: naviationController)
        window.rootViewController = naviationController
    }
}
