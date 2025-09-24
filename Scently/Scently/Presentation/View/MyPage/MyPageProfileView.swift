//
//  MyPageProfileView.swift
//  Scently
//
//  Created by 임재현 on 8/16/25.
//

import UIKit
import SnapKit

protocol MyPageProfileViewDelegate: AnyObject {
    func profileEditButtonDidTap()
}

final class MyPageProfileView: UIView {
    
    weak var delegate: MyPageProfileViewDelegate?
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
//        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 32
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let usernameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.medium, size: 16)
        titleLabel.textColor = .black
        titleLabel.text = "김아무개"
        
        return titleLabel
    }()
    
    let mailLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.medium, size: 12)
        titleLabel.textColor = .gray3
        titleLabel.text = "aaaaaa@gmail@com"
        
        return titleLabel
    }()
    
    let profileEditButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("프로필 수정", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .pretendard(.medium, size: 11)
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.layer.cornerRadius = 6
        button.backgroundColor = .white
        
        return button
    }()
    
    private let dividerView = DividerView()


    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageProfileView {
    
    private func setupUI() {
        self.addSubviews(
            profileImageView,
            usernameLabel,
            mailLabel,
            profileEditButton,
            dividerView
        )
    }
    
    private func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(64)
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview().offset(16)
        }
        
        usernameLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        mailLabel.snp.makeConstraints {
            $0.top.equalTo(usernameLabel.snp.bottom).offset(8)
            $0.leading.equalTo(usernameLabel.snp.leading)
        }
        
        profileEditButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(16)
            $0.width.equalTo(69)
            $0.height.equalTo(23)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)  
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    private func setupAddTarget() {
        profileEditButton.addTarget(self, action: #selector(editButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func editButtonDidTap() {
        delegate?.profileEditButtonDidTap()
    }
}


