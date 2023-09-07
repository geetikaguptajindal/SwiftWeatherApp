//
//  Model.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation
import Combine

protocol SearchViewModelInputProtocol {
    func getCities(city: String)
}

protocol SearchViewModelOutput {
    var cityPublisher: AnyPublisher<[City], Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
}

protocol SearchViewModel: SearchViewModelInputProtocol, SearchViewModelOutput {
    var input : SearchViewModelInputProtocol { get }
    var output : SearchViewModelOutput { get }
}
    
final class DefaultSearchViewModel: SearchViewModel {
    private var defaultSearchUseCases: SearchUseCases
    private var cancellable = Set<AnyCancellable>()

    var input : SearchViewModelInputProtocol { self }
    var output : SearchViewModelOutput { self }
    
    var citySubject =  PassthroughSubject<[City], Never> ()
    var errorSubject = PassthroughSubject<String, Never> ()
    
    var cityPublisher: AnyPublisher<[City], Never> {
        return citySubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    init(_defaultSearchUseCases: SearchUseCases) {
        defaultSearchUseCases = _defaultSearchUseCases
        bindPublisher()
    }
    
    func getCities(city: String) {
        defaultSearchUseCases.getCities(city: city)
    }
    
    func bindPublisher() {
        defaultSearchUseCases.cityPublisher.sink { [weak self] cities in
            self?.citySubject.send(cities)
        }.store(in: &cancellable)
        
        defaultSearchUseCases.errorPublisher.sink { [weak self] errorString in
            self?.errorSubject.send(errorString)
        }.store(in: &cancellable)
    }
}

