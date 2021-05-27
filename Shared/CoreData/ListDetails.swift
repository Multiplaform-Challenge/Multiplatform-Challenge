//
//  ListDetails.swift
//  MultiplatformChallenge
//
//  Created by José Mateus Azevedo on 24/05/21.
//

import CoreData

struct ListDetails {

    let shoppingList: ShoppingList

    var id: NSManagedObjectID {
        return shoppingList.objectID
    }

    var budget: Double {
        return shoppingList.budget
    }

    var objective: String {
        return shoppingList.objective ?? ""
    }
}
