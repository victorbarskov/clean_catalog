//
//  MapRouter.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

import UIKit

@objc protocol MapRoutingLogic {
    // Implement function to route to some other view: for example after success login
    func routeToShowView(segue: UIStoryboardSegue?)
}

protocol MapDataPassing {
    var dataStore: MapDataStore? { get }
}

class MapRouter: NSObject, MapRoutingLogic, MapDataPassing {
    
    var dataStore: MapDataStore?
    weak var viewController: MapViewController?
    
    func routeToShowView(segue: UIStoryboardSegue?) {
        // Here use segue to show new view
    }
    
    // MARK: - Navigation -
    // Navigate with showing destionation view for example: show(_ vc: UIViewController, sender: Any?)
    
    // MARK: - Passing data -
    // Pass data to destionation view
    
}
