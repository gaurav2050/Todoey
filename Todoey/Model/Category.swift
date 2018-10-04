//
//  Category.swift
//  Todoey
//
//  Created by Gaurav Rangnani on 24/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation
import RealmSwift

class Category: Object {
    @objc dynamic var name: String = ""
    let items = List<Item>()
}
