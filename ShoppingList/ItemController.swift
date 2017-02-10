//
//  ItemController.swift
//  ShoppingList
//
//  Created by Andrew Ervin Gierke on 2/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation
import CoreData

class ItemController {
    
    static let shared = ItemController()
    
    //computed item property that checks persistent data everytime property is hit
    var items: [Item] {
        //get request
        let request: NSFetchRequest<Item> = Item.fetchRequest()
        return (try? CoreDataStack.context.fetch(request)) ?? []
    }
    
    //MARK: - crud
    
    func addItemNamed(name: String) {
        let _ = Item(name: name, hasPurchased: false)
        saveToPersistentStore()
    }
    
    func delete(item: Item) {
        CoreDataStack.context.delete(item)
        saveToPersistentStore()
    }
    
    func toggleHasPurchased(item: Item) {
        item.hasPurchased = !item.hasPurchased
        saveToPersistentStore()
    }
    
    
    //MARK: - Data persistence
    
    func saveToPersistentStore() {
        do {
            try CoreDataStack.context.save()
        } catch let error {
            print("There was a problemo saving: \(error)")
        }
    }
    
    
    
    
}
