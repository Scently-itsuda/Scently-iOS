//
//  PhotoCell.swift
//  Scently
//
//  Created by 임재현 on 11/14/25.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    
    var onDeleteTapped: (() -> Void)?
    
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        return iv
    }()
    
    private lazy var deleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        button.tintColor = .white
        button.backgroundColor = .black.withAlphaComponent(0.4)
        button.layer.cornerRadius = 12
        button.clipsToBounds = true
        button.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
        setupConstraints()

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubviews(imageView,deleteButton)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(16)
        }
    }
    
    func configure(with image: UIImage) {
        imageView.image = image
    }
    
    @objc private func deleteButtonTapped() {
        onDeleteTapped?()
    }
}
