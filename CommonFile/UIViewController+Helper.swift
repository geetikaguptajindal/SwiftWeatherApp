//
//  UIViewController+Helper.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

extension UIViewController {
    
    static func instantiateFromViewController() -> Self {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(withIdentifier: String(describing: Self.self)) as? Self else {
            fatalError("")
        }
        return viewController
    }
}
