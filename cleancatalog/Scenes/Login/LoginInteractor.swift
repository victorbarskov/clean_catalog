//
//  LoginInteractor.swift
//  cleancatalog
//
//  Created by Victor Barskov on 20/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

protocol LoginBusinessLogic
{
    // Here we put business logic such as creating the log in
    func login(request: LoginModel.Login.Request)
}

protocol LoginDataStore
{
    var user: User? { get }
}

class LoginInteractor: LoginBusinessLogic, LoginDataStore {
    
    var user: User?
    var presenter: LoginPresentationLogic?
    let worker = LoginWorker()
    
    // MARK: -  Business Logic Implementation -
    // Implement business logic and use it in presenter
    func login(request: LoginModel.Login.Request) {
        // Here with request parameters ask Worker to make the log in
        worker.makeLogin(email: request.email, password: request.password) { (user, error) in
            if error != nil {
                print("Error on LogIn: \(error.debugDescription)")
            } else {
                // Do something with user
                if user != nil {
                    let presentLogin = LoginModel.Login.Response(success: true, user: user)
                    // Call the presenter here and give Login response there
                    presenter?.presentLogin(response: presentLogin)
                }
            }
        }
    }

}
