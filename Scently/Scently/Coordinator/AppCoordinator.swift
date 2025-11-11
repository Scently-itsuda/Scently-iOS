//
//  AppCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import UIKit

protocol Coordinator: AnyObject {
    var childCoordinators: [Coordinator] { get set }
    
    func start()
}

class AppCoordinator: Coordinator {
    
    var childCoordinators: [Coordinator] = []
    
    private let window: UIWindow
    private let authService: AuthServiceProtocol
    
    init(window: UIWindow, authservice: AuthServiceProtocol) {
        self.window = window
        self.authService = authservice
    }
    
    func start() {
        print("Coordinator 시작")
        
        if authService.hasValidToken() {
            print("토큰 있음 - MainTab으로 이동 예정")
            showMainTab(isGuest: false)
        } else {
            print("토큰 없음 - Login으로 이동 예정")
            showLogin()
        }
    }
    
    private func showLogin() {
        let navigationController = UINavigationController()
        let loginCoordinator = LoginCoordinator(
            navigationConotroller: navigationController,
            authService: authService)
        
        loginCoordinator.onLoginSuccess = {
            print("로그인 성공")
            self.removeChild(loginCoordinator)
            self.showMainTab(isGuest: false)
        }
        
        loginCoordinator.onGuestMode = {
            print("둘러보기 모드")
            self.removeChild(loginCoordinator)
            self.showMainTab(isGuest: true)
        }
        
        childCoordinators.append(loginCoordinator)
        loginCoordinator.start()
        
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        
    }
    
    private func showMainTab(isGuest: Bool) {
        let tabBarController = UITabBarController()
        let mainTabCoordinator = MainTabCoordinator(
            tabBarController: tabBarController,
            authService: authService,
            isGuestMode: isGuest
        )
        
        
        mainTabCoordinator.onLoginRequired = {
            self.removeChild(mainTabCoordinator)
            self.showLogin()
        }
        
        childCoordinators.append(mainTabCoordinator)
        mainTabCoordinator.start()

        window.rootViewController = tabBarController
        window.makeKeyAndVisible()
    }
    
    private func removeChild(_ coordinator: Coordinator?) {
        guard let coordinator = coordinator else {return}
        
        childCoordinators.removeAll { $0 === coordinator }
    }
}
