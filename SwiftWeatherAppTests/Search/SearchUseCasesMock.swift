//
//  SearchUseCasesMock.swift
//  SwiftWeatherAppTests
//
//  Created by Geetika Gupta on 08/09/23.
//

import XCTest
import Combine

@testable import SwiftWeatherApp

class SearchUseCasesMock : SearchUseCases {
    var searchWithName: String?
    var searchWithCallsCount = 0
    var publisherCalledCount = 0
    
    private var citySubjectMock =  PassthroughSubject<[City], Never> ()
    private var errorSubjectMock = PassthroughSubject<String, Never> ()
    
    var cityPublisher: AnyPublisher<[City], Never> {
        citySubjectMock.eraseToAnyPublisher()
    }
    var errorPublisher: AnyPublisher<String, Never> {
        errorSubjectMock.eraseToAnyPublisher()
    }
    
    func getCities(city: String) {
        self.searchWithCallsCount = +1
        self.searchWithName = city
        
        if !city.isEmpty  {
            citySubjectMock.send([City(city: city, country: "Country")])
            publisherCalledCount = +1
        } else {
            errorSubjectMock.send("InvalidData")
            publisherCalledCount = +1
        }
    }
}
