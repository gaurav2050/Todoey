//
//  Item.swift
//  Todoey
//
//  Created by Gaurav Rangnani on 24/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import RealmSwift

class Item: Object {
    @objc dynamic var isSelected: Bool = false
    @objc dynamic var title: String = ""
    @objc dynamic var dateCreated: Date?
    var parentCategory = LinkingObjects(fromType: Category.self, property: "items")
}
