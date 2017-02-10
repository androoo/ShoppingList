//
//  Item + Convenience.swift
//  ShoppingList
//
//  Created by Andrew Ervin Gierke on 2/10/17.
//  Copyright © 2017 Androoo. All rights reserved.
//

import Foundation
import CoreData


extension Item {
    @discardableResult convenience init(name: String, hasPurchased: Bool = false, context: NSManagedObjectContext = CoreDataStack.context) {
        self.init(context: context)
        self.name = name
        self.hasPurchased = hasPurchased
    }
}
