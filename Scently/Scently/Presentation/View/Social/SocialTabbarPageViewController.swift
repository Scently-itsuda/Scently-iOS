//
//  SocialTabbarPageViewController.swift
//  Scently
//
//  Created by sy0201 on 5/21/25.
//

import UIKit

final class SocialTabbarPageViewController: UIPageViewController {
    var tabbarViewModel = TabBarViewModel()
    
    init() {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabbarViewModel.setupViewControllers()
        self.view.backgroundColor = .clear
    }
}
