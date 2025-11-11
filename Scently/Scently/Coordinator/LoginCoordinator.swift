//
//  LoginCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import UIKit

protocol LoginCoordinatorProtocol {
    func didTapLogin(email: String, password: String)
    func didTapGuestMode()
}

class LoginCoordinator: Coordinator,LoginCoordinatorProtocol {
    
    var childCoordinators: [Coordinator] = []
    
    private let navigationConotroller: UINavigationController
    private let authService: AuthServiceProtocol
    
    var onLoginSuccess: (()->Void)?
    var onGuestMode: (()->Void)?
    
    init(navigationConotroller: UINavigationController, authService: AuthServiceProtocol) {
        self.navigationConotroller = navigationConotroller
        self.authService = authService
    }
    
    func start() {
        let loginVC = LoginViewController()
       // loginVC.coordinator = self
        navigationConotroller.setViewControllers([loginVC], animated: false)
    }
    
    func didTapLogin(email: String, password: String) {
        authService.saveToken("dummy_token_\(email)")
        onLoginSuccess?()
    }
    
    func didTapGuestMode() {
        onGuestMode?()
    }
}
