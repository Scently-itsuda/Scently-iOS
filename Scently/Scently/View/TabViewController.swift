//
//  TabViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class TabViewController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setTabbar()
        setAttribute()
    }
    
    // MARK: - Tabbar Setting
    func setTabbar() {
        let appearanceTabbar = UITabBarAppearance()
        appearanceTabbar.configureWithOpaqueBackground()
        appearanceTabbar.backgroundColor = UIColor.black
        tabBar.standardAppearance = appearanceTabbar
        tabBar.scrollEdgeAppearance = appearanceTabbar
        tabBar.tintColor = .white
        tabBar.backgroundColor = .black
    }
    
    // MARK: - Tabbar 화면이동 및 눌렸을때/눌리지 않았을때 이미지 Set
    func setAttribute() {
        
        // MARK: - UIBar Create NavigtaionController
        viewControllers = [
          createNavController(for: PerfumeViewController(), title: NSLocalizedString("PERFUME", comment: ""), image: UIImage(named: "icon-nav-perfume")!, selectedImage: UIImage(named: "icon-nav-perfume-off")!),
          createNavController(for: SocialViewController(), title: NSLocalizedString("SOCIAL", comment: ""), image: UIImage(named: "icon-nav-social")!, selectedImage: UIImage(named: "icon-nav-social-off")!),
          createNavController(for: HomeViewController(), title: NSLocalizedString("HOME", comment: ""), image: UIImage(named: "icon-nav-home")!, selectedImage: UIImage(named: "icon-nav-home-off")!),
          createNavController(for: LikeViewController(), title: NSLocalizedString("LIKE", comment: ""), image: UIImage(named: "icon-nav-like")!, selectedImage: UIImage(named: "icon-nav-like-off")!),
          createNavController(for: MyViewController(), title: NSLocalizedString("MY", comment: ""), image: UIImage(named: "icon-nav-my")!, selectedImage:UIImage(named: "icon-nav-my-off")!)
        ]
    }
    
    // MARK: - Tabbar 화면이동 및 눌렸을때/눌리지 않았을때 이미지 Set
    fileprivate func createNavController(for rootViewController: UIViewController, title: String?, image: UIImage, selectedImage: UIImage) -> UIViewController {
        
        let navController = UINavigationController(rootViewController:  rootViewController)
        let appearance = UINavigationBarAppearance()
           appearance.configureWithOpaqueBackground()
           appearance.backgroundColor = .white
           
           navController.navigationBar.isHidden = true
           navController.navigationBar.standardAppearance = appearance
           navController.navigationBar.scrollEdgeAppearance = appearance
           navController.navigationBar.compactAppearance = appearance
           
           navController.navigationBar.isTranslucent = false
           navController.navigationBar.backgroundColor = .blue
           appearance.shadowColor = .clear

           navController.tabBarItem.title = title
           navController.tabBarItem.image = image
           navController.tabBarItem.selectedImage = selectedImage
         //  navController.interactivePopGestureRecognizer?.delegate = nil
           
           return navController
    }
}
