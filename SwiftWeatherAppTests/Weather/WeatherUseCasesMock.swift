//
//  WeatherUseCasesMock.swift
//  SwiftWeatherAppTests
//
//  Created by Geetika Gupta on 08/09/23.
//

import XCTest
import Combine

@testable import SwiftWeatherApp

class WeatherUseCasesMock : WeatherUseCases {
    
    var searchWithName: String?
    var searchWithCallsCount = 0
    var publisherCalledCount = 0
    
    private var weatherSubjectMock =  PassthroughSubject<WeatherLocalData, Never> ()
    private var errorSubjectMock = PassthroughSubject<String, Never> ()
    private var imageDataSubject =  PassthroughSubject<Data, Never> ()

    var errorPublisher: AnyPublisher<String, Never> {
        errorSubjectMock.eraseToAnyPublisher()
    }
    
    var weatherPublisher: AnyPublisher<WeatherLocalData, Never> {
        weatherSubjectMock.eraseToAnyPublisher()
    }
    
    var imageDataPublisher: AnyPublisher<Data, Never> {
        imageDataSubject.eraseToAnyPublisher()
    }
    
    func getWeatherDetail(city: String) {
        
    }
    
    func loadimage(with icon: String) {
        
    }
}
