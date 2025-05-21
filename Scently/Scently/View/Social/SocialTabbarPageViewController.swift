//
//  SocialTabbarPageViewController.swift
//  Scently
//
//  Created by sy0201 on 5/21/25.
//

import UIKit

final class SocialTabbarPageViewController: UIPageViewController {
    lazy var pageViewController: UIPageViewController = {
        let vc = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
        
        return vc
    }()
    
    var tabbarViewModel = TabBarViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarViewModel.setupViewControllers()
    }
}
