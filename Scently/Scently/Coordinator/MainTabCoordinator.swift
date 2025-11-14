//
//  MainTabCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import UIKit


protocol MainTabCoordinatorProtocol: AnyObject {
    func requiresLogin(completion: @escaping (Bool) -> Void)
    func showLoginScreen()
    func logout()
}

class MainTabCoordinator: Coordinator, MainTabCoordinatorProtocol {

    var childCoordinators: [Coordinator] = []
    
    private let tabBarController: UITabBarController
    private let authService: AuthServiceProtocol
    private let isGuestMode: Bool
    
    var onLoginRequired: (() -> Void)?
    var onLogout: (() -> Void)?
    
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
        let socialNav = createSocialTab()
        let homeVC = HomeViewController()
        let likeVC = LikeViewController()
        let myVC = MyViewController()
        
        myVC.coordinator = self
        myVC.isGuestMode = isGuestMode
        
        let perfumeNav = createNavController(
            for: perfumeVC,
            title: NSLocalizedString("PERFUME", comment: ""),
            image: UIImage(named: "icon-nav-perfume")!,
            selectedImage: UIImage(named: "icon-nav-perfume-off")!
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
    
    func requiresLogin(completion: @escaping (Bool) -> Void) {
        let alert = UIAlertController(
            title: "로그인이 필요합니다",
            message: "이 기능을 사용하려면 로그인이 필요합니다. \n로그인 하시겠습니까?",
            preferredStyle: .alert
        )
        
        let loginAction = UIAlertAction(title: "로그인", style: .default) { _ in
            completion(true)
        }
        
        let cancleAction = UIAlertAction(title: "취소", style: .cancel) { _ in
            completion(false)
        }
        
        alert.addAction(cancleAction)
        alert.addAction(loginAction)
        
        tabBarController.present(alert, animated: true)
    }
    
    func showLoginScreen() {
        onLoginRequired?()
    }
    func logout() {
        let alert = UIAlertController(
            title: "로그아웃",
            message: "정말 로그아웃하시겠습니까?",
            preferredStyle: .alert
        )
        
        let logoutAction = UIAlertAction(title: "로그아웃", style: .destructive) { [weak self] _ in
            self?.authService.clearToken()
            print("토큰 삭제 완료")
            
            self?.onLogout?()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(logoutAction)
        
        tabBarController.present(alert, animated: true)
    }
}

extension MainTabCoordinator {
    private func createSocialTab() -> UINavigationController {
        let navigationController = UINavigationController()
        
        let socialCoordinator = SocialCoordinator(
            navigationController: navigationController,
            authService: authService,
            isGusetMode: isGuestMode)
        
        socialCoordinator.onLoginRequired = { [weak self] in
            self?.onLoginRequired?()
        }
        
        childCoordinators.append(socialCoordinator)
        
        let socialVC = SocialViewController()
        
        socialVC.coordinator = socialCoordinator
        socialVC.isGuestMode = isGuestMode
        
        let ootdVC = OOTDViewController()
        let freeBoardVC = FreeBoardViewController()
        let reviewVC = ReviewViewController()
        
        ootdVC.coordinator = socialCoordinator
        freeBoardVC.coordinator = socialCoordinator
        reviewVC.coordinator = socialCoordinator
        
        socialVC.tabbarViewModel.dataSourceVC = [ootdVC,freeBoardVC,reviewVC]
        
        navigationController.setViewControllers([socialVC], animated: false)
        
        let appearance = UINavigationBarAppearance()
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = .white
        appearance.shadowColor = .clear
        
        navigationController.navigationBar.isHidden = true
        navigationController.navigationBar.standardAppearance = appearance
        navigationController.navigationBar.scrollEdgeAppearance = appearance
        navigationController.navigationBar.compactAppearance = appearance
        navigationController.navigationBar.isTranslucent = false
        
        // TabBarItem 설정
        navigationController.tabBarItem.title = NSLocalizedString("SOCIAL", comment: "")
        navigationController.tabBarItem.image = UIImage(named: "icon-nav-social")
        navigationController.tabBarItem.selectedImage = UIImage(named: "icon-nav-social-off")
        
        return navigationController
        
    }
}
