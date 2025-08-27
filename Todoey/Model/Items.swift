//
//  Items.swift
//  Todoey
//
//  Created by Apple on 17/08/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift
class Items : Object {
    @objc dynamic var name : String = ""
    @objc dynamic var done : Bool = false
    @objc dynamic var dateadded : Date?
    var parentcategory = LinkingObjects(fromType: Category.self, property: "item")

}
