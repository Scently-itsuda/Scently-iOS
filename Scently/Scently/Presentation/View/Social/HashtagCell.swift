//
//  HashtagCell.swift
//  Scently
//
//  Created by 임재현 on 11/16/25.
//

import UIKit
import SnapKit

class HashtagCell: UICollectionViewCell {
    
    private let containerView: UIView = {
        let view = UIView()
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemGray4.cgColor
        view.backgroundColor = .white
        return view
    }()
    
    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .black
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(containerView)
        containerView.addSubview(hashtagLabel)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hashtagLabel.snp.makeConstraints {
            $0.top.bottom.equalToSuperview().inset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
    }
    
    func configure(with hashtag: String, isSelected: Bool) {
        hashtagLabel.text = "#\(hashtag)"
        
        if isSelected {
            containerView.backgroundColor = .systemBlue
            containerView.layer.borderColor = UIColor.systemBlue.cgColor
            hashtagLabel.textColor = .white
        } else {
            containerView.backgroundColor = .white
            containerView.layer.borderColor = UIColor.systemGray4.cgColor
            hashtagLabel.textColor = .black
        }
    }
}
