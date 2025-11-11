//
//  MainTabCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import UIKit

class MainTabCoordinator: Coordinator {

    var childCoordinators: [Coordinator] = []
    
    private let tabBarController: UITabBarController
    private let authService: AuthServiceProtocol
    private let isGuestMode: Bool
    
    init(tabBarController: UITabBarController, authService: AuthServiceProtocol, isGuestMode: Bool) {
        self.tabBarController = tabBarController
        self.authService = authService
        self.isGuestMode = isGuestMode
    }
    
    func start() {
        setupTabBar()
    }
    
    private func setupTabBar() {
        let perfumeVC = PerfumeViewController()
        let socialVC = SocialViewController()
        let homeVC = HomeViewController()
        let likeVC = LikeViewController()
        let myVC = MyViewController()
        
        let perfumeNav = createNavController(
            for: perfumeVC,
            title: NSLocalizedString("PERFUME", comment: ""),
            image: UIImage(named: "icon-nav-perfume")!,
            selectedImage: UIImage(named: "icon-nav-perfume-off")!
        )
        
        let socialNav = createNavController(
            for: socialVC,
            title: NSLocalizedString("SOCIAL", comment: ""),
            image: UIImage(named: "icon-nav-social")!,
            selectedImage: UIImage(named: "icon-nav-social-off")!
        )
        
        let homeNav = createNavController(
            for: homeVC,
            title: NSLocalizedString("HOME", comment: ""),
            image: UIImage(named: "icon-nav-home")!,
            selectedImage: UIImage(named: "icon-nav-home-off")!
        )
        
        let likeNav = createNavController(
            for: likeVC,
            title: NSLocalizedString("LIKE", comment: ""),
            image: UIImage(named: "icon-nav-like")!,
            selectedImage: UIImage(named: "icon-nav-like-off")!
        )
        
        let myNav = createNavController(
            for: myVC,
            title: NSLocalizedString("MY", comment: ""),
            image: UIImage(named: "icon-nav-my")!,
            selectedImage: UIImage(named: "icon-nav-my-off")!
        )
        
        tabBarController.viewControllers = [perfumeNav,socialNav,homeNav,likeNav,myNav]
        tabBarController.selectedIndex = 2
        
        setupTabBarAppearance()
    
    }
    
    private func setupTabBarAppearance() {
        let appearance = UITabBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .black
        
        tabBarController.tabBar.standardAppearance = appearance
        tabBarController.tabBar.scrollEdgeAppearance = appearance
        tabBarController.tabBar.tintColor = .white
        tabBarController.tabBar.backgroundColor = .black
    }
    
    private func createNavController(
        for rootViewController: UIViewController,
        title: String?,
        image: UIImage,
        selectedImage: UIImage
    ) -> UIViewController {
        let navController = UINavigationController(rootViewController: rootViewController)
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        navController.navigationBar.isHidden = true
        navController.navigationBar.standardAppearance = appearance
        navController.navigationBar.scrollEdgeAppearance = appearance
        navController.navigationBar.compactAppearance = appearance
        navController.navigationBar.isTranslucent = false
        
        navController.tabBarItem.title = title
        navController.tabBarItem.image = image
        navController.tabBarItem.selectedImage = selectedImage
        
        return navController
    }
}
