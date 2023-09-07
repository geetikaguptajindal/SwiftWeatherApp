//
//  DefaultSearchUseCases.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation
import Combine

protocol WeatherUseCases {
    func getWeatherDetail(city: String)

    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
}

final class DefaultWeatherUseCases: WeatherUseCases {
    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> {
        weatherSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        errorSubject.eraseToAnyPublisher()
    }

    // singelton object of network class which is in objective C, can not creating Dependency injection
    private let networkManeger: NetworkManager = NetworkManager.shared()
    
    private var weatherSubject =  PassthroughSubject<WeatherLocalData, Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
    private var cancellable = Set<AnyCancellable>()

    func getWeatherDetail(city: String) {
        let weatherTarget = WeatherTargetType.getCityWeather(city: city)
        let completePath = weatherTarget.basePath.appending(weatherTarget.endPath)        
        guard let url: URL = URL(string: completePath) else {
            return
        }
        
        networkManeger.performGETRequest(weatherTarget.parameter, url: url) { [weak self] responseObject in
            do {
                let json = try JSONSerialization.data(withJSONObject: responseObject)
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: json)
                let weatherLocalResponse = weatherResponse.intoWeatherLocalData()
                print(weatherLocalResponse)
                self?.weatherSubject.send(weatherLocalResponse)
            } catch {
                print(error)
                self?.errorSubject.send(StringConstant.decodeError)
            }
        } failure: { [weak self] errorString, statusCode in
            print(errorString, statusCode)
            self?.errorSubject.send(errorString)            
        }
    }
}
    
