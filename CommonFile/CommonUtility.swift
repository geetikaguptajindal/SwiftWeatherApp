//
//  CommonUtility.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 06/09/23.
//

import Foundation

enum ServerError: Error {
    case incorrectURL(String)
    case decodeError(String)
    case genericError(String)
    case incorrectStatusCode(String)
    case invalidRequest
}

