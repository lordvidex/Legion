//
//  TodoCategory.swift
//  Todoey
//
//  Created by Evans Owamoyo on 15.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import Foundation
import Realm
import RealmSwift

class TodoCategory: Object {
    @Persisted var name: String = ""
    @Persisted var items = List<TodoItem>()
    @Persisted var color: String = "000000"
}
