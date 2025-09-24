//
//  ProfileEditUserProfileView.swift
//  Scently
//
//  Created by 임재현 on 8/17/25.
//

import UIKit
import SnapKit

final class ProfileEditUserProfileView: UIView {
    
    private var nameLabel: UILabel = {
        let label = UILabel()
        label.text = "이름"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        
        return label
    }()
    
    private var nameInputView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        
        let nameValueLabel = UILabel()
        nameValueLabel.text = "사용자 이름"
        nameValueLabel.font = .pretendard(.regular, size: 16)
        nameValueLabel.textColor = .systemGray2
        
        containerView.addSubview(nameValueLabel)
        nameValueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        return containerView
    }()
    
    private var emailLabel: UILabel = {
        let label = UILabel()
        label.text = "이메일"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        
        return label
    }()
    
    private var emailInputView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = UIColor.systemGray6
        containerView.layer.cornerRadius = 8
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.systemGray4.cgColor
        
        let nameValueLabel = UILabel()
        nameValueLabel.text = "limjh9298@gmail.com"
        nameValueLabel.font = .pretendard(.regular, size: 16)
        nameValueLabel.textColor = .systemGray2
        
        containerView.addSubview(nameValueLabel)
        nameValueLabel.snp.makeConstraints { make in
            make.leading.trailing.equalToSuperview().inset(16)
            make.centerY.equalToSuperview()
        }
        
        return containerView
    }()
   
    private var  nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        
        return label
    }()
    
    private var  birthdayLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        
        return label
    }()
    
    private var birthdayInputView: UIView = {
        let containerView = UIView()
        containerView.backgroundColor = .white
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        containerView.layer.cornerRadius = 8
        
        let dateButton = UIButton(type: .system)
        dateButton.setTitle("0000.00.00", for: .normal)
        dateButton.setTitleColor(.lightGray, for: .normal)
        dateButton.titleLabel?.font = .pretendard(.regular, size: 16)
        dateButton.backgroundColor = .clear
        dateButton.contentHorizontalAlignment = .left
        dateButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        
        containerView.addSubview(dateButton)
        dateButton.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        return containerView
    }()
    
    private var nicknameInputView = NicknameInputView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProfileEditUserProfileView {
    private func setupUI() {
        self.addSubviews(
            nicknameLabel,
            nicknameInputView,
            birthdayLabel,
            birthdayInputView,
            nameLabel,
            nameInputView,
            emailLabel,
            emailInputView
        )
    }
    
    
    private func setupConstraints() {
        
        nameLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(60)
        }
//        
        nameInputView.snp.makeConstraints {
            $0.leading.equalTo(nameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(nameLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        emailLabel.snp.makeConstraints {
            $0.top.equalTo(nameInputView.snp.bottom).offset(32)
            $0.leading.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        emailInputView.snp.makeConstraints {
            $0.leading.equalTo(emailLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(emailLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(emailInputView.snp.bottom).offset(32)
            $0.leading.equalToSuperview()
            $0.width.equalTo(60)
            
        }
        
        nicknameInputView.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(nicknameLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
        }
//        
        birthdayLabel.snp.makeConstraints {
            $0.top.equalTo(nicknameInputView.snp.bottom).offset(32)
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.width.equalTo(60)
            
        }
        
        birthdayInputView.snp.makeConstraints {
            $0.leading.equalTo(birthdayLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(birthdayLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(52)
            $0.bottom.equalToSuperview()
        }
    }
}
