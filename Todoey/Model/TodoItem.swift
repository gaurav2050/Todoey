//
//  File.swift
//  Todoey
//
//  Created by Gaurav Rangnani on 13/09/18.
//  Copyright © 2018 Gaurav. All rights reserved.
//

import Foundation

class TodoItem: Codable {
    var title: String
    var isSelected: Bool = false
    
    init() {
        title = ""
    }
}
