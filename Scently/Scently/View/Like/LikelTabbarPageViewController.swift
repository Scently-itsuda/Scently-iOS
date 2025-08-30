//
//  LikelTabbarPageViewController.swift
//  Scently
//
//  Created by 임재현 on 8/24/25.
//

import UIKit

final class LikelTabbarPageViewController: UIPageViewController {
    var tabbarViewModel = LikeTapBarViewModel()
    
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

