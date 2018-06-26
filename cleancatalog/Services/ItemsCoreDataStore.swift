//
//  ItemsCoreDataStore.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation
import CoreData

class ItemsCoreDataStore: ItemsStoreProtocol {
    
    // MARK: - Core Data stack
    
    // CoreData Managed object contexts
    
    var mainManagedObjectContext: NSManagedObjectContext
    var privateManagedObjectContext: NSManagedObjectContext
    
    // Object lifecycle
    
    init() {
        // This resource is the same name as your xcdatamodeld contained in your project.
        guard let modelURL = Bundle.main.url(forResource: "cleancatalog", withExtension: "momd") else {
            fatalError("Error loading model from bundle")
        }
        
        // The managed object model for the application. It is a fatal error for the application not to be able to find and load its model.
        guard let mom = NSManagedObjectModel(contentsOf: modelURL) else {
            fatalError("Error initializing mom from: \(modelURL)")
        }
        
        let psc = NSPersistentStoreCoordinator(managedObjectModel: mom)
        mainManagedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        mainManagedObjectContext.persistentStoreCoordinator = psc
        
        let urls = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let docURL = urls[urls.endIndex-1]
        /* The directory the application uses to store the Core Data store file.
         This code uses a file named "DataModel.sqlite" in the application's documents directory.
         */
        let storeURL = docURL.appendingPathComponent("cleancatalog.sqlite")
        do {
            try psc.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: storeURL, options: nil)
        } catch {
            fatalError("Error migrating store: \(error)")
        }

        privateManagedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        privateManagedObjectContext.parent = mainManagedObjectContext
        
    }
    
    deinit {
        do {
            try self.mainManagedObjectContext.save()
        } catch {
            fatalError("Error deinitializing main managed object context")
        }
    }
    
    // MARK: - ItemsStoreProtocol methods implementation -
    
    // MARK: - CRUD operations with optional error
    
    func fetchItems(completionHandler: @escaping ([Item], ItemsStoreError?) -> Void) {
        
        privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedItem")
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedItem]
                let items = results.map { $0.toItem() }
                completionHandler(items, nil)
            } catch {
                completionHandler([], ItemsStoreError.CannotFetch("Cannot fetch items"))
            }
        }
    }
    
    func fetchItem(id: String, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
        
        privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedItem")
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedItem]
                if let item = results.first?.toItem() {
                    completionHandler(item, nil)
                } else {
                    completionHandler(nil, ItemsStoreError.CannotFetch("Cannot fetch item with id \(id)"))
                }
            } catch {
                completionHandler(nil, ItemsStoreError.CannotFetch("Cannot fetch item with id \(id)"))
            }
        }
    }
    
    func createItem(itemToCreate: Item, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
        
        // Create item depends on id predicate of the given item
        
        privateManagedObjectContext.perform {
            do {
                let managedItem = NSEntityDescription.insertNewObject(forEntityName: "ManagedItem", into: self.privateManagedObjectContext) as! ManagedItem
                managedItem.fromItem(item: itemToCreate)
                try self.privateManagedObjectContext.save()
                completionHandler(itemToCreate, nil)
            } catch {
                completionHandler(nil, ItemsStoreError.CannotCreate("Cannot create item with id \(String(describing: itemToCreate.id))"))
            }
        }
        
    }
    
    func updateItem(itemToUpdate: Item, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
       // Create item depends on id predicate of the given item
    }
    
    func deleteItem(id: String, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
        // Create item depends on id predicate of the given item
    }
    
    // MARK: - CRUD operations with inner closure
    
    func fetchItems(completionHandler: @escaping (() throws -> [Item]) -> Void) {
        
        privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedItem")
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedItem]
                let items = results.map { $0.toItem() }
                completionHandler { return items }
            } catch {
                completionHandler { throw ItemsStoreError.CannotFetch("Cannot fetch items") }
            }
        }
        
    }
    
    func fetchItem(id: String, completionHandler: @escaping (() throws -> Item?) -> Void) {
        // Fetch item depends on id predicate
        privateManagedObjectContext.perform {
            do {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "ManagedItem")
                fetchRequest.predicate = NSPredicate(format: "id == %@", id)
                let results = try self.privateManagedObjectContext.fetch(fetchRequest) as! [ManagedItem]
                if let item = results.first?.toItem(){
                    completionHandler { return item }
                } else {
                    throw ItemsStoreError.CannotFetch("Cannot fetch item with id \(id)")
                }
            } catch {
                completionHandler { throw ItemsStoreError.CannotFetch("Cannot fetch item with id \(id)") }
            }
        }
    }
    
    func createItem(itemToCreate: Item, completionHandler: @escaping (() throws -> Item?) -> Void) {
        // Create item depends on id predicate of the given item
        
        privateManagedObjectContext.perform {
            do {
                let managedItem = NSEntityDescription.insertNewObject(forEntityName: "ManagedItem", into: self.privateManagedObjectContext) as! ManagedItem
                managedItem.fromItem(item: itemToCreate)
                try self.privateManagedObjectContext.save()
                completionHandler { return itemToCreate }
            } catch {
                completionHandler { throw ItemsStoreError.CannotCreate("Cannot create item with id \(String(describing: itemToCreate.id))") }
            }
        }
    }
    
    func updateItem(itemToUpdate: Item, completionHandler: @escaping (() throws -> Item?) -> Void) {
        // Update item depends on id predicate of the given item
    }
    
    func deleteItem(id: String, completionHandler: @escaping (() throws -> Item?) -> Void) {
        // Delete item depends on id predicate of the given item
    }
    
    
}
