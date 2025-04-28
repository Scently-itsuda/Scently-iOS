//
//  SceneDelegate.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
   
        guard let windowScene = (scene as? UIWindowScene) else { return }
        let window = UIWindow(windowScene: windowScene)
        let loginViewController = LoginViewController()
        let navigationController = UINavigationController(rootViewController: loginViewController)
        window.rootViewController = navigationController
        window.makeKeyAndVisible()
        self.window = window
        
    }
}

