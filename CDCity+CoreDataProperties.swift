//
//  CDCity+CoreDataProperties.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 11/09/23.
//
//

import Foundation
import CoreData


extension CDCity {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<CDCity> {
        return NSFetchRequest<CDCity>(entityName: "CDCity")
    }

    @NSManaged public var country: String?
    @NSManaged public var id: UUID?
    @NSManaged public var name: String?
    @NSManaged public var toWeather: Set<CDWeather>?
}

// MARK: Generated accessors for toWeather
extension CDCity {

    @objc(addToWeatherObject:)
    @NSManaged public func addToToWeather(_ value: CDWeather)

    @objc(removeToWeatherObject:)
    @NSManaged public func removeFromToWeather(_ value: CDWeather)

    @objc(addToWeather:)
    @NSManaged public func addToToWeather(_ values: Set<CDWeather>?)

    @objc(removeToWeather:)
    @NSManaged public func removeFromToWeather(_ values: Set<CDWeather>?)

}

extension CDCity : Identifiable {

}
