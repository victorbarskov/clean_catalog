//
//  LoginViewController.swift
//  cleancatalog
//
//  Created by Victor Barskov on 20/04/2018.
//  Copyright © 2018 YUZTEKH INTEGRATSIYA. All rights reserved.
//

import UIKit

protocol LoginDisplayLogic: class {
    // Implement display logic such as showing user the result of the login cycle
    func displayLogin(viewModel: LoginModel.Login.ViewModel)
}

class LoginViewController: UIViewController, LoginDisplayLogic {

    var interactor: LoginBusinessLogic?
    var router: (NSObjectProtocol & LoginRoutingLogic & LoginDataPassing)?
    
    // MARK: - Object lifecycle -
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?)
    {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder)
    {
        super.init(coder: aDecoder)
        setup()
    }
    
    private func setup() {
        
        let viewController = self
        let interactor = LoginInteractor()
        let presenter = LoginPresenter()
        viewController.interactor = interactor
        interactor.presenter = presenter
        presenter.viewController = viewController
        
        let router = LoginRouter()
        viewController.router = router
        router.viewController = viewController
        router.dataStore = interactor
        
    }
    
    func login(email: String, password: String){
        let request = LoginModel.Login.Request(email: email, password: password)
        interactor?.login(request: request)
    }
    
    func displayLogin(viewModel: LoginModel.Login.ViewModel) {
        if viewModel.success {
            showGreeting(output: viewModel.loginOutput)
        } else {
            showErrors()
        }
    }
    
    func showGreeting(output: String){
        print("Here is outpt of your Login: \(output)")
    }
    
    func showErrors() {
        print("Sorry. Something went wrong")
    }

}
