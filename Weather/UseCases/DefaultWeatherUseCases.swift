//
//  DefaultSearchUseCases.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation
import Combine

protocol WeatherUseCases {
    func getWeatherDetail()
    func loadimage(with icon: String)
    
    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    var imageDataPublisher: AnyPublisher<Data, Never> { get }
}

final class DefaultWeatherUseCases: WeatherUseCases {
    
    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> {
        weatherSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        errorSubject.eraseToAnyPublisher()
    }
    
    var imageDataPublisher: AnyPublisher<Data, Never> {
        imageDataSubject.eraseToAnyPublisher()
    }

    // singelton object of network class which is in objective C, can not creating Dependency injection
    private let networkManeger: NetworkManager = NetworkManager.shared()
    
    private var weatherSubject =  PassthroughSubject<WeatherLocalData, Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
    private var imageDataSubject =  PassthroughSubject<Data, Never> ()

    private var cancellable = Set<AnyCancellable>()
    private let cityObj: City
    
    
    init(with cityObj: City) {
        self.cityObj = cityObj
    }
    
    func getWeatherDetail() {
        let weatherTarget = WeatherTargetType.getCityWeather(city: cityObj.city)
        let completePath = weatherTarget.basePath.appending(weatherTarget.endPath)        
        guard let url: URL = URL(string: completePath) else {
            return errorSubject.send(StringConstant.invalidURL)
        }
        
        networkManeger.performGETRequest(weatherTarget.parameter, url: url) { [weak self] responseObject in
            guard let self else { return }
            do {
                let json = try JSONSerialization.data(withJSONObject: responseObject)
                let decoder = JSONDecoder()
                let weatherResponse = try decoder.decode(WeatherResponse.self, from: json)
                let weatherLocalResponse = weatherResponse.intoWeatherLocalData(withCity: self.cityObj)
                self.weatherSubject.send(weatherLocalResponse)
            } catch {
                self.errorSubject.send(StringConstant.decodeError)
            }
        } failure: { [weak self] errorString, statusCode in
            print(errorString, statusCode)
            self?.errorSubject.send(errorString)            
        }
    }
    
    //Load image
    func loadimage(with icon: String) {
        let weatherTarget = WeatherTargetType.getImage(icon: icon)
        let completePath = weatherTarget.basePath.appending(weatherTarget.endPath).appending("\(icon).png")

        LoadImage.imageFromServerURL(urlString: completePath) { [weak self] data in
            self?.imageDataSubject.send(data)
        }
    }
}
    
