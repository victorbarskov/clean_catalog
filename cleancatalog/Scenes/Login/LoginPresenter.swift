//
//  LoginPresenter.swift
//  cleancatalog
//
//  Created by Victor Barskov on 20/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import Foundation

protocol LoginPresentationLogic
{
    // Here we implement presentation logic for login such as preparation for User object for presentation
    func presentLogin(response: LoginModel.Login.Response)
}

class LoginPresenter: LoginPresentationLogic {
    
    weak var viewController: LoginDisplayLogic?

    // MARK: - LoginPresentationLogic Implementation -
    // Implement preparation of User object presentation and give it to view controller to present
    
    func presentLogin(response: LoginModel.Login.Response) {
        
        let greeting = response.success ? "Hello \(response.user?.name ?? "")" : ""
        let viewModel = LoginModel.Login.ViewModel(success: response.success, loginOutput: greeting)
        
        // Display login and put the the ViewModel
        viewController?.displayLogin(viewModel: viewModel)
    }
}

