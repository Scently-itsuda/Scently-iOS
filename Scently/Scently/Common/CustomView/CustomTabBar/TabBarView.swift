//
//  TabBarView.swift
//  Scently
//
//  Created by sy0201 on 5/16/25.
//

import UIKit
import SnapKit

final class TabBarView: UIView {
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        //flowLayout.minimumLineSpacing = 12
        flowLayout.minimumInteritemSpacing = 12
        flowLayout.scrollDirection = .horizontal

        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        collectionView.backgroundColor = .white
        
        return collectionView
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarView {
    func setupUI() {
        self.addSubview(collectionView)
    }
    
    func setupConstraint() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
