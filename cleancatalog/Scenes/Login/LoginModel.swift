//
//  LoginModel.swift
//  cleancatalog
//
//  Created by Victor Barskov on 20/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

enum LoginModel
    
{
    // MARK: Use cases
    
    enum Login {
        struct Request{
            var email: String
            var password: String
        }
        struct Response{
            var success: Bool
            var user: User?
        }
        struct ViewModel{
            var success: Bool
            var loginOutput: String
        }
    }
}
