//
//  UIDateTime+Helper.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation

extension Date {
    
    static func getCureentDate() -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy hh.mm"
        let dateString = formatter.string(from: Date())
        return dateString
    }
}
