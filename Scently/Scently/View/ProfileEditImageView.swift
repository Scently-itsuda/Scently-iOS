//
//  ProfileEditImageView.swift
//  Scently
//
//  Created by 임재현 on 8/17/25.
//

import UIKit
import SnapKit

final class ProfileEditImageView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightgray
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 40
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    let imageChangeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이미지 변경", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .pretendard(.medium, size: 11)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        
        return button
    }()
    
    let imageDeleteButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("이미지 삭제", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .pretendard(.medium, size: 11)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        
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

extension ProfileEditImageView {
    private func setupUI() {
        self.addSubviews(
            profileImageView,
            imageChangeButton,
            imageDeleteButton
        )
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(80)
            $0.centerX.centerY.equalToSuperview()
        }
        
        imageChangeButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.trailing.equalTo(profileImageView.snp.centerX).offset(-8)
            $0.width.equalTo(69)
            $0.height.equalTo(23)
        }
        
        imageDeleteButton.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.leading.equalTo(profileImageView.snp.centerX).offset(8)
            $0.width.equalTo(69)
            $0.height.equalTo(23)
        }
    }
}
