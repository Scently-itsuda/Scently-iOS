//
//  SignUpCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import UIKit

class SignUpCoordinator: Coordinator {
    var childCoordinators: [Coordinator] = []
    
    private let navigationController: UINavigationController
    private let authService: AuthServiceProtocol
    private let socialToken: String
    
    var onSignUpComplete: (()->Void)?
    
    init(navigationController: UINavigationController, authService: AuthServiceProtocol, socialToken: String) {
        self.navigationController = navigationController
        self.authService = authService
        self.socialToken = socialToken
    }
    
    func start() {
        let signUpVC = SignUpViewController()
        signUpVC.socialToken = socialToken
        signUpVC.coordinator = self
        navigationController.pushViewController(signUpVC, animated: true)
    }
    
    func didCompleteSignUp() {
        authService.saveToken(socialToken)
        onSignUpComplete?()
    }
    
    
}

