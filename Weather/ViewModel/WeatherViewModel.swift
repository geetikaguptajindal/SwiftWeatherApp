//
//  WeatherViewModel.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation
import Combine

protocol WeatherViewModelOutput {
    var weatherPublisher: AnyPublisher<(WeatherLocalData, Data?), Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    var cityName: String { get }
}

protocol WeatherViewModel: WeatherViewModelOutput {
    var output : WeatherViewModelOutput { get }
}
    
final class DefaultWeatherViewModel: WeatherViewModel {
    
    private var defaultWeatherUseCases: WeatherUseCases
    private var cancellable = Set<AnyCancellable>()
    private var weatherInfo: WeatherLocalData!
    var output : WeatherViewModelOutput { self }
    
    private var weatherSubject =  PassthroughSubject<(WeatherLocalData, Data?), Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
        
    private var city: String = ""
    
    var weatherPublisher: AnyPublisher<(WeatherLocalData, Data?), Never> {
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
            self?.weatherInfo = weather
            self?.weatherSubject.send((weather, nil))
            self?.downloadImageUrl()
        }.store(in: &cancellable)
        
        defaultWeatherUseCases.errorPublisher.sink { [weak self] errorString in
            self?.errorSubject.send(errorString)
        }.store(in: &cancellable)
        
        defaultWeatherUseCases.imageDataPublisher.sink { [weak self] data in
            if let weatherInfo = self?.weatherInfo {
                self?.weatherSubject.send((weatherInfo, data))
            }
        }.store(in: &cancellable)
    }
    
    var cityName: String {
        city
    }
    
    func downloadImageUrl() {
        let imageDownloadQueue = DispatchQueue(label: QueueIdentidier.downloadImgae, attributes: .concurrent)
        imageDownloadQueue.async {
            self.defaultWeatherUseCases.loadimage(with: self.weatherInfo.icon)
        }
    }
}

