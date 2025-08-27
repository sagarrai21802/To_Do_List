//
//  Category.swift
//  Todoey
//
//  Created by Apple on 17/08/25.
//  Copyright © 2025 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift

class Category : Object {
    @objc dynamic var title : String = ""
    var item = List<Items>()

}
