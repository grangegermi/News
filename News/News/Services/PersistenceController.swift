//
//  ModelFavorites.swift
//  News
//
//  Created by Даша Волошина on 18.05.25.
//

import Foundation
import CoreData

class PersistenceController  {
    
   static let shared = PersistenceController()
    
    let container: NSPersistentContainer
    var context: NSManagedObjectContext {
           container.viewContext
       }
    
    init () {
        container = NSPersistentContainer(name: "FavoritesModel")
        container.loadPersistentStores { description, error in
            if let error = error {
                fatalError("\(error)")
            } else {
                print("\(description)")
            }
        }
    } 
}
