//
//  Item+CoreDataProperties.swift
//  Todoey
//
//  Created by Sagar Rai on 06/08/2025.
//  Copyright © 2025 App Brewery. All rights reserved.
//
//

import Foundation
import CoreData


extension Item {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Item> {
        return NSFetchRequest<Item>(entityName: "Item")
    }

    @NSManaged public var done: Bool
    @NSManaged public var title: String?

}

extension Item : Identifiable {

}
