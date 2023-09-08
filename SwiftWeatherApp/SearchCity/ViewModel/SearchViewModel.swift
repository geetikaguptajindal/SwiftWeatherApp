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
    func saveRecord(cityObj: City) -> Bool
}

protocol SearchViewModelOutput {
    var cityPublisher: AnyPublisher<[City], Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
    func selectedCity(row: Int) -> City
}

protocol SearchViewModel: SearchViewModelInputProtocol, SearchViewModelOutput {
    var input : SearchViewModelInputProtocol { get }
    var output : SearchViewModelOutput { get }
}
    
final class DefaultSearchViewModel: SearchViewModel {
    var defaultSearchUseCases: SearchUseCases
    private var cancellable = Set<AnyCancellable>()
    private var cityList = [City]()
    let cdCityManager: CDCityLayerProtocol!
    
    var input : SearchViewModelInputProtocol { self }
    var output : SearchViewModelOutput { self }
    
    private var citySubject =  PassthroughSubject<[City], Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
    
    var cityPublisher: AnyPublisher<[City], Never> {
        return citySubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    init(_defaultSearchUseCases: SearchUseCases, withCDManager _cdCityManager: CDCityLayerProtocol) {
        defaultSearchUseCases = _defaultSearchUseCases
        cdCityManager = _cdCityManager
        bindPublisher()
    }
    
    func getCities(city: String) {
        defaultSearchUseCases.getCities(city: city)
    }
    
    private func bindPublisher() {
        defaultSearchUseCases.cityPublisher.sink { [weak self] cities in
            self?.cityList = cities
            self?.citySubject.send(cities)
        }.store(in: &cancellable)
        
        defaultSearchUseCases.errorPublisher.sink { [weak self] errorString in
            self?.cityList = []
            self?.citySubject.send([])
            self?.errorSubject.send(errorString)
        }.store(in: &cancellable)
    }
    
    func selectedCity(row: Int) -> City {
        return cityList[row]
    }
}

//Mark:- Core Data operation
extension DefaultSearchViewModel {
    func saveRecord(cityObj: City) -> Bool {
        cdCityManager.createPerson(record: cityObj)
    }
}

