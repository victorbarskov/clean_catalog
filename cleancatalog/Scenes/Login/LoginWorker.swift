//
//  LoginWorker.swift
//  cleancatalog
//
//  Created by Victor Barskov on 23/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

class LoginWorker {
    
    func makeLogin(email: String, password: String, completionHandler: (User?, Error?)-> Void) {
        // Use API methods to log in and return User object on success
        let user = User(id: "id", name: "UserTest")
        completionHandler(user, nil)
    }
    
}
