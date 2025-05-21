//
//  TabBarCollectionViewCell.swift
//  Scently
//
//  Created by sy0201 on 5/16/25.
//

import UIKit
import SnapKit

final class TabBarCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    let containerView = UIView()
    
    let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.regular, size: 14)
        titleLabel.textColor = .gray3
        
        return titleLabel
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    override var isSelected: Bool {
        didSet {
            titleLabel.font = isSelected ? .pretendard(.bold, size: 14) : .pretendard(.regular, size: 14)
            titleLabel.textColor = isSelected ? .black : .gray3
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension TabBarCollectionViewCell {
    func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(titleLabel)
    }
    
    func setupConstraint() {
        containerView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.bottom.equalToSuperview().inset(14)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
        }
    }
}
