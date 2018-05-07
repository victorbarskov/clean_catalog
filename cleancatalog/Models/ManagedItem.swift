//
//  ManagedItem.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation
import CoreData

class ManagedItem: NSManagedObject {
    
    func toItem() -> Item {
        return Item(id: id, name: name)
    }
    
    func fromItem(item: Item){
        id = item.id
        name = item.name
    }
}

