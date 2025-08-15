//
//  FreeBoardUserProfileview.swift
//  Scently
//
//  Created by 임재현 on 8/15/25.
//

import UIKit
import SnapKit

final class FreeBoardUserProfileview: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
//        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nickNameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.medium, size: 14)
        titleLabel.textColor = .black
        titleLabel.text = "marvel"
        
        return titleLabel
    }()

    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-more"), for: .normal)
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
    
}

extension FreeBoardUserProfileview {
    func setupUI() {
        self.addSubviews(
            profileImageView,
            nickNameLabel,
            moreButton
        )
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(41)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(profileImageView)
        }
        

        moreButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.centerY.equalTo(profileImageView)
        }
    }
    
    func configure(with profile: String) {
        
    }
}

