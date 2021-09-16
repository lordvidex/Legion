//
//  TodoItem.swift
//  Todoey
//
//  Created by Evans Owamoyo on 15.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import RealmSwift


class TodoItem: EmbeddedObject {
    @Persisted var title: String = ""
    @Persisted var done: Bool = false
    let parentCategory = LinkingObjects(fromType: TodoCategory.self, property: "items")
}
