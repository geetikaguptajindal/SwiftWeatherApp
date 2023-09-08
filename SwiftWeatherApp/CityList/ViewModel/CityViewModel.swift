//
//  CityViewModel.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
//

import Foundation
import Combine

protocol CityViewModelInput {
    func getCities()
}

protocol CityViewModelOutput {
    var cityPublisher: AnyPublisher<[City], Never> { get }
}

protocol CityViewModel: CityViewModelInput, CityViewModelOutput {
    var input : CityViewModelInput { get }
    var output : CityViewModelOutput { get }
}
    
final class DefaultCityViewModel: CityViewModel {
    private var cityList = [City]()
    fileprivate let cdCityManager: CDCityCDLayer!
    
    var input : CityViewModelInput { self }
    var output : CityViewModelOutput { self }
    
    private var citySubject =  PassthroughSubject<[City], Never> ()
    
    var cityPublisher: AnyPublisher<[City], Never> {
        return citySubject.eraseToAnyPublisher()
    }
    
    init(withCDManager _cdCityManager: CDCityCDLayer) {
        cdCityManager = _cdCityManager
    }
}

//Mark:- Core Data operation
extension DefaultCityViewModel {
    func getCities() {
        guard let cdCityes = cdCityManager.getAll() else {
            citySubject.send([])
            return
        }
        citySubject.send(cdCityes)
    }
}

