//
//  WeatherViewModel.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation
import Combine

protocol WeatherViewModelOutput {
    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    var cityName: String { get }
}

protocol WeatherViewModel: WeatherViewModelOutput {
    var output : WeatherViewModelOutput { get }
}
    
final class DefaultWeatherViewModel: WeatherViewModel {
    private var defaultWeatherUseCases: WeatherUseCases
    private var cancellable = Set<AnyCancellable>()

    var output : WeatherViewModelOutput { self }
    
    private var weatherSubject =  PassthroughSubject<WeatherLocalData, Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
        
    private var city: String = ""
    
    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> {
        return weatherSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    init(_defaultWeatherUseCases: WeatherUseCases, withCity name: String) {
        defaultWeatherUseCases = _defaultWeatherUseCases
        bindPublisher()
        getCityWeather(city: name)
    }
    
    private func getCityWeather(city: String) {
        self.city = city
        defaultWeatherUseCases.getWeatherDetail(city: city)
    }
    
    func bindPublisher() {
        defaultWeatherUseCases.weatherPublisher.sink { [weak self] weather in
            self?.weatherSubject.send(weather)
        }.store(in: &cancellable)
        
        defaultWeatherUseCases.errorPublisher.sink { [weak self] errorString in
            self?.errorSubject.send(errorString)
        }.store(in: &cancellable)
    }
    
    var cityName: String {
        city
    }
}

