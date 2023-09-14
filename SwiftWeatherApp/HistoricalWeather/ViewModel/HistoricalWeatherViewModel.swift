//
//  HistoricalWeatherViewModel.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation
import Combine


protocol HistoricalWeatherViewModelOutput {
    func getAllHistoricalWeather()
        
    var weatherPublisher: AnyPublisher<([WeatherLocalData]), Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    
    var cityName:String { get }
}

protocol HistoricalWeatherViewModel: HistoricalWeatherViewModelOutput {
    var output : HistoricalWeatherViewModelOutput { get }
}
   
final class DefaultHistoricalWeatherViewModel: HistoricalWeatherViewModel {
    var weatherLayer: CDWeatherLayerProtocol
    var output : HistoricalWeatherViewModelOutput { self }
    var cityObj: City
    
    private var weatherSubject =  PassthroughSubject<([WeatherLocalData]), Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
    
    var weatherPublisher: AnyPublisher<([WeatherLocalData]), Never> {
        return weatherSubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    init(weatherLayer: CDWeatherLayerProtocol, cityObj: City) {
        self.weatherLayer = weatherLayer
        self.cityObj = cityObj
    }
    
    func getAllHistoricalWeather(){
        guard let weatherList = self.weatherLayer.getAll(withCityUUID: cityObj.id) else { return }
        
        weatherSubject.send(weatherList)
    }
    
    var cityName:String {
        self.cityObj.city
    }

}
