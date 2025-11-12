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
    
    private let navigationController: UINavigationController
    private let authService: AuthServiceProtocol
    
    var onLoginSuccess: (()->Void)?
    var onGuestMode: (()->Void)?
    var onSignUpRequired: ((String) -> Void)?
    
    init(navigationConotroller: UINavigationController, authService: AuthServiceProtocol) {
        self.navigationController = navigationConotroller
        self.authService = authService
    }
    
    func start() {
        let loginVC = LoginViewController()
        loginVC.coordinator = self
        navigationController.setViewControllers([loginVC], animated: false)
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
        let socialToken = "kakao_token_new_user"
        handleSocialLoginSuccess(token: socialToken, provider: "kakao")
    }
    
    private func performAppleLogin() {
        // TODO: 애플 로그인 로직
        print("Coordinator: 애플 로그인 시작")
        let socialToken = "apple_token_existing"
        handleSocialLoginSuccess(token: socialToken, provider: "apple")
    }
    
    private func handleSocialLoginSuccess(token: String, provider: String) {
        print("소셜 로그인 성공\(provider)")
        
        authService.checkUserRegistration(token: token) { [weak self] result in
            switch result {
            case .success(let isRegistered):
                if isRegistered {
                    self?.authService.saveToken(token)
                    self?.onLoginSuccess?()
                } else {
                    print("신규회원 - 회원가입 화면으로 이동")
                    self?.onSignUpRequired?(token)
                }
            case .failure(let error):
                print("회원 확인 실패: \(error)")
                self?.showErrorAlert(message: "로그인 중 오류가 발생했습니다")
            }
        }
    }
    
    private func showErrorAlert(message: String) {
        let alert = UIAlertController(
            title: "오류",
            message: message,
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        navigationController.present(alert, animated: true)
    }
}
