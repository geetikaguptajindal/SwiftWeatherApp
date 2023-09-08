//
//  DefaultSearchUseCases.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 07/09/23.
//

import Foundation
import Combine

protocol SearchUseCases {
    func getCities(city: String)
    
    var cityPublisher: AnyPublisher<[City], Never> { get }
    var errorPublisher: AnyPublisher<String, Never> { get }
}

final class DefaultSearchUseCases: SearchUseCases {
    private let networkManeger: NetworkManager
    private var cancellable = Set<AnyCancellable>()

    private var citySubject =  PassthroughSubject<[City], Never> ()
    private var errorSubject = PassthroughSubject<String, Never> ()
    
    var cityPublisher: AnyPublisher<[City], Never> {
        return citySubject.eraseToAnyPublisher()
    }
    
    var errorPublisher: AnyPublisher<String, Never> {
        return errorSubject.eraseToAnyPublisher()
    }
    
    init(networkManeger: NetworkManager) {
        self.networkManeger = networkManeger
    }
    
    func getCities(city: String) {
        let cityTarget = CityTargetType.getCitys(city: city)
        let completePath = cityTarget.basePath.appending(cityTarget.endPath)        
        guard let url: URL = URL(string: completePath) else {
            return errorSubject.send(StringConstant.invalidURL)
        }
        
        networkManeger.performGETRequest(cityTarget.parameter, url: url) { [weak self] responseObject in
            do {
                let json = try JSONSerialization.data(withJSONObject: responseObject)
                let decoder = JSONDecoder()
                let cities = try decoder.decode([String].self, from: json)
                
                let cityModel = cities.map { cityName in
                    let joinNames = cityName.components(separatedBy: ",")
                    return City(city: city, country: joinNames.last ?? "")
                }
                self?.citySubject.send(cityModel)
            } catch {
                self?.errorSubject.send(StringConstant.decodeError)
            }
           
        } failure: { [weak self] errorString, statusCode in
            print(errorString, statusCode)
            self?.errorSubject.send(errorString)
        }
    }
}
    
