//
//  LoginCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import UIKit

protocol LoginCoordinatorProtocol: AnyObject {
    func didTapSocialLogin(type: SocialLoginType)
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
        loginVC.coordinator = self
        navigationConotroller.setViewControllers([loginVC], animated: false)
    }
    
    func didTapSocialLogin(type: SocialLoginType) {
        switch type {
        case .kakao:
            performKakaoLogin()
        case .apple:
            performAppleLogin()

        case .none:
            break 
        }
    }
    
    func didTapGuestMode() {
        onGuestMode?()
    }
    
    private func performKakaoLogin() {
        // TODO: 카카오 로그인 로직
        print("Coordinator: 카카오 로그인 시작")
    }
    
    private func performAppleLogin() {
        // TODO: 애플 로그인 로직
        print("Coordinator: 애플 로그인 시작")
    }
}
