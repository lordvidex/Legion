//
//  TodoManager.swift
//  Todoey
//
//  Created by Evans Owamoyo on 14.08.2021.
//  Copyright © 2021 App Brewery. All rights reserved.
//

import UIKit
import RealmSwift
import ChameleonFramework

protocol TodoManagerDelegate {
    /// closure for actions that will be called when data changes to updateUI
    func onDataChanged(_ todoManager: TodoManager)
}

class TodoManager {
    private init() {}
    static let shared = TodoManager()
    
    private let realm = try! Realm()
    
    
    /// Delegate instance that contains methods used to update UI / ViewControllers
    /// that implement the protocol `TodoManagerDelegate`
    var delegate: TodoManagerDelegate?
    
    /// Array of current todos
    var todos: Results<TodoItem>?
    
    /// Array of current categories
    var categories: Results<TodoCategory>?
    
    // MARK: - TodoItems functions
    
    /// fetches all items when request is not provided
    ///
    func loadItems(inCategory category: TodoCategory) {
        todos = category.items.sorted(byKeyPath: "title")
        delegate?.onDataChanged(self)
        
    }
    
    /// Loads item and returns an array of `TodoItem` where
    /// - `title` contains the `searchText`
    /// <<R>>
    func loadItems(inCategory category: TodoCategory, withQuery searchText: String) {
        
        todos = category.items
            .filter(NSPredicate(format: "title CONTAINS[cd] %@", searchText))
        
        delegate?.onDataChanged(self)
    }
    
    /// <<C>>
    func addItem(inCategory category: TodoCategory, withTitle title: String) {
        saveData {
            let item = TodoItem()
            item.title = title
            category.items.append(item)
        }
    }
    
    /// <<U>>
    func toggleDoneForTodo(at index: Int) {
        saveData {
            todos![index].done = !todos![index].done
        }
    }
    
    /// <<D>>
    func deleteItem(_ item: TodoItem) {
        saveData {
            realm.delete(item)
        }
    }
    
    // MARK: - Category functions
    
    func addCategory(withTitle title: String) {
        
        saveData {
            let category = TodoCategory()
            category.name = title
            category.color = UIColor.randomFlat().hexValue()
            
            realm.add(category)
        }
    }
    
    func deleteCategory(_ category: TodoCategory) {
        saveData {
            realm.delete(category)
        }
    }
    
    func loadCategories() {
        categories = realm.objects(TodoCategory.self)
        delegate?.onDataChanged(self)
    }
    
    // MARK: - Helper functions and items
    
    private func saveData(action: () -> Void) {
        do {
            try realm.write {
                action()
            }
            delegate?.onDataChanged(self)
        } catch {
            print("Error saving data: \(error)")
        }
    }
}
