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
    
    func navigateToRepoDetails() {
        let searchViewController = SearchViewController.instantiateFromViewController()
        self.navigationController?.pushViewController(searchViewController, animated: true)
    }
}
