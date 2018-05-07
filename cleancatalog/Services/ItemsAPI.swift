//
//  ItemsAPI.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

class ItemsAPI: ItemsStoreProtocol {
    
    // Implementation of CRUD operations with inner closure
    
    func fetchItems(completionHandler: @escaping (() throws -> [Item]) -> Void) {
    }
    
    func fetchItem(id: String, completionHandler: @escaping (() throws -> Item?) -> Void) {
    }
    
    func createItem(itemToCreate: Item, completionHandler: @escaping (() throws -> Item?) -> Void) {
    }
    
    func updateItem(itemToUpdate: Item, completionHandler: @escaping (() throws -> Item?) -> Void) {
    }
    
    func deleteItem(id: String, completionHandler: @escaping (() throws -> Item?) -> Void) {
    }
    
    
    // Implementation of CRUD operations with optional error
    
    func fetchItems(completionHandler: @escaping ([Item], ItemsStoreError?) -> Void) {
    }
    
    func fetchItem(id: String, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
    }
    
    func createItem(itemToCreate orderToCreate: Item, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
    }
    
    func updateItem(itemToUpdate orderToUpdate: Item, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
    }
    
    func deleteItem(id: String, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void) {
    }
    
    
}
