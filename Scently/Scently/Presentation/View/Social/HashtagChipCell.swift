//
//  HashtagChipCell.swift
//  Scently
//
//  Created by 임재현 on 11/19/25.
//

import UIKit

class HashtagChipCell: UICollectionViewCell {
    
    var onDeleteTapped: (() -> Void)?
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .systemBlue.withAlphaComponent(0.1)
        view.layer.cornerRadius = 16
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.systemBlue.cgColor
        return view
    }()
    
    private let hashtagLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .systemBlue
        return label
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
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
        containerView.addSubview(deleteButton)
        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        hashtagLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.leading.equalTo(hashtagLabel.snp.trailing).offset(6)
            $0.trailing.equalToSuperview().offset(-8)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(20)
            $0.top.bottom.equalToSuperview().inset(8)
        }
    }
    
    @objc private func deleteButtonTapped() {
        onDeleteTapped?()
    }
    
    func configure(with hashtag: String) {
        hashtagLabel.text = "#\(hashtag)"
    }
}
