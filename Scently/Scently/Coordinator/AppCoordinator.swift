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
        } else {
            print("토큰 없음 - Login으로 이동 예정")
        }
    }
}
