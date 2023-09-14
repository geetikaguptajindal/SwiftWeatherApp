//
//  WeatherRepository.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//

import Foundation
import CoreData

protocol WeatherRepos: BaseRepository {
    func getWeatherForCity(byIdentifier id: UUID) -> [WeatherLocalData]?
}

struct WeatherRepository: WeatherRepos {
    
    typealias T = WeatherLocalData

    func create(record: WeatherLocalData) {
        let cdWeather = CDWeather(context: PersistentStorage.shared.context)
        cdWeather.id = UUID()
        cdWeather.humidity = record.humidity
        cdWeather.wind = record.speed
        cdWeather.temp = record.temp
        cdWeather.cityId = record.cityObj?.id

        cdWeather.wDescription = record.description
        cdWeather.timeStamp = record.fetchTimeStamp
        
        guard let cityObj = record.cityObj else {
            return
        }
        let cdCity = self.getCity(withUUID: cityObj.id)
        if let cityObj = cdCity{
            cdWeather.toCity = cityObj
            PersistentStorage.shared.saveContext()
        }
    }
    
    func getAll() -> [WeatherLocalData]? {
        let record = PersistentStorage.shared.fetchManagedObject(managedObject: CDWeather.self)
        
        guard let weatherRecord = record, weatherRecord.count >= 1 else {
            return nil
        }
        
        var weatherList  = [WeatherLocalData]()
        weatherRecord.forEach { cdWeather in
            weatherList.append(WeatherLocalData(temp: cdWeather.temp, speed: cdWeather.wind, humidity: cdWeather.humidity, description: cdWeather.wDescription ?? "", icon: "", fetchTimeStamp: cdWeather.timeStamp ?? ""))
        }
        return weatherList
        
    }
    
    func getWeatherForCity(byIdentifier id: UUID) -> [WeatherLocalData]? {
        let fetchRequest = NSFetchRequest<CDWeather>(entityName: "CDWeather")
        let predicate = NSPredicate(format: "cityId==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let record = try PersistentStorage.shared.context.fetch(fetchRequest) as [CDWeather]
            guard record.count >= 1 else {
                return nil
            }
            
            var weatherLocalData = [WeatherLocalData]()
            record.forEach { cdWeather in
                if let weatherInfo = cdWeather.convertToWeather() {
                    weatherLocalData.append(weatherInfo)
                }
            }
            
            return weatherLocalData
        } catch {
            print("error")
        }
        return nil
    }
    
    private func getCity(withUUID id: UUID) -> CDCity? {
        let fetchRequest = NSFetchRequest<CDCity>(entityName: "CDCity")
        let predicate = NSPredicate(format: "id==%@", id as CVarArg)
        fetchRequest.predicate = predicate
        
        do {
            let record = try PersistentStorage.shared.context.fetch(fetchRequest)
            guard record.count >= 1 else {
                return nil
            }
            return record.first
        } catch {
            print("error")
        }
        
        return nil
    }
    
    
    
}
