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
    lazy var collectionView = UICollectionView()
    
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
    }
    
    func setupConstraint() {
        navigationView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
