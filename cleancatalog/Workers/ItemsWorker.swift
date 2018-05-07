//
//  ItemsWorker.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

class ItemsWorker
{
    var itemsStore: ItemsStoreProtocol
    
    init(itemsStore: ItemsStoreProtocol){
        self.itemsStore = itemsStore
    }
    
}

// MARK: - Items store API

protocol ItemsStoreProtocol {
    // MARK: CRUD operations with optional error
    
    func fetchItems(completionHandler: @escaping ([Item], ItemsStoreError?) -> Void)
    func fetchItem(id: String, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void)
    func createItem(itemToCreate: Item, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void)
    func updateItem(itemToUpdate: Item, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void)
    func deleteItem(id: String, completionHandler: @escaping (Item?, ItemsStoreError?) -> Void)
    
    // MARK: CRUD operations with inner closure
    
    func fetchItems(completionHandler: @escaping (() throws -> [Item]) -> Void)
    func fetchItem(id: String, completionHandler: @escaping (() throws -> Item?) -> Void)
    func createItem(itemToCreate: Item, completionHandler: @escaping (() throws -> Item?) -> Void)
    func updateItem(itemToUpdate: Item, completionHandler: @escaping (() throws -> Item?) -> Void)
    func deleteItem(id: String, completionHandler: @escaping (() throws -> Item?) -> Void)
    
}

// MARK: - Items store CRUD operation errors

enum ItemsStoreError: Equatable, Error {
    case CannotFetch(String)
    case CannotCreate(String)
    case CannotUpdate(String)
    case CannotDelete(String)
}

