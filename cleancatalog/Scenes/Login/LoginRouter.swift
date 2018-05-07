//
//  LoginRouter.swift
//  cleancatalog
//
//  Created by Victor Barskov on 20/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation
import UIKit

@objc protocol LoginRoutingLogic
{
    // Implement function to route to some other view: for example after success login
    func routeToShowView(segue: UIStoryboardSegue?)
}

protocol LoginDataPassing
{
    var dataStore: LoginDataStore? { get }
}

class LoginRouter: NSObject, LoginRoutingLogic, LoginDataPassing {
    
    var dataStore: LoginDataStore?
    weak var viewController: LoginViewController?
    
    func routeToShowView(segue: UIStoryboardSegue?) {
        // Here use segue to show new view
    }
    
    // MARK: - Navigation -
    // Navigate with showing destionation view for example: show(_ vc: UIViewController, sender: Any?)
    
    // MARK: - Passing data -
    // Pass data to destionation view

}
