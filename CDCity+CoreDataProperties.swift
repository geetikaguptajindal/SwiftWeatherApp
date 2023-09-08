//
//  CDCity+CoreDataProperties.swift
//  SwiftWeatherApp
//
//  Created by Geetika Gupta on 08/09/23.
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

}

extension CDCity : Identifiable {

}
