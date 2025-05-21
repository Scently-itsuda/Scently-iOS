//
//  SocialView.swift
//  Scently
//
//  Created by sy0201 on 5/9/25.
//

import UIKit
import SnapKit

final class SocialView: UIView {
    private var navigationView = NavigationView()
    let tabbarView = TabBarView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension SocialView {
    func setupUI() {
        self.addSubview(navigationView)
        self.addSubview(tabbarView)
    }
    
    func setupConstraint() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide.snp.top)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        tabbarView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
    }
}
