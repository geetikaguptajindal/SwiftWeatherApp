//
//  DefaultSearchUseCases.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation

protocol WeatherUseCases {
    
    func getDetail(city: String)

}

final class DefaultWeatherUseCases: WeatherUseCases {
    
    //let networkManager: NetworkManager = NetworkManager.shared()
    
    private let networkManeger: NetworkManager

    init(networkManeger: NetworkManager) {
        self.networkManeger = networkManeger
    }
    
    func getDetail(city: String) {
        let weatherTarget = WeatherTargetType.getCityWeather(city: city)
        
        let completePath = weatherTarget.basePath.appending(weatherTarget.endPath)
        
        guard let url: URL = URL(string: completePath) else {
            return
        }
        
        networkManeger.performGETRequest(weatherTarget.parameter, url: url) { responseObject in
            do {
                let json = try JSONSerialization.data(withJSONObject: responseObject)
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: json)
                let weatherLocalResponse = weatherResponse.intoWeatherLocalData()
                print(weatherLocalResponse)

            } catch {
                print(error)
            }
        } failure: { errorString, statusCode in
            print(errorString, statusCode)
            
        }
    }
}
    
