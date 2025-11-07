//
//  ProfileEditViewController.swift
//  Scently
//
//  Created by 임재현 on 8/17/25.
//

import UIKit
import SnapKit

final class ProfileEditViewController: UIViewController {

    private var profileEditNavigationView = ProfileEditNavigationView()
    private var profileEditImageView = ProfileEditImageView()
    private var profileEditUserProfileView = ProfileEditUserProfileView()
    
    private let saveButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("저장하기", for: .normal)
        button.setTitleColor(.white, for: .normal)
        button.titleLabel?.font = .pretendard(.medium, size: 16)
        button.backgroundColor = .lightgray
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let withdrawButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("탈퇴하기", for: .normal)
        button.setTitleColor(.lightgray, for: .normal)
        button.titleLabel?.font = .pretendard(.regular, size: 14)
        button.backgroundColor = .clear
        
        let attributedTitle = NSAttributedString(
            string: "탈퇴하기",
            attributes: [
                .underlineStyle: NSUnderlineStyle.single.rawValue,
                .foregroundColor: UIColor.lightgray,
                .font: UIFont.pretendard(.regular, size: 14)
            ]
        )
        button.setAttributedTitle(attributedTitle, for: .normal)
        
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        profileEditNavigationView.delegate = self
    }
}

extension ProfileEditViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubviews(
            profileEditNavigationView,
            profileEditImageView,
            profileEditUserProfileView,
            saveButton,
            withdrawButton
        )
        profileEditNavigationView.configure(title: "프로필 수정")
    }
    private func setupConstraints() {
        profileEditNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        profileEditImageView.snp.makeConstraints {
            $0.top.equalTo(profileEditNavigationView.snp.bottom).offset(8)
            $0.leading.trailing.trailing.equalToSuperview()
            $0.height.equalTo(100)
        }
        
        profileEditUserProfileView.snp.makeConstraints {
            $0.top.equalTo(profileEditImageView.snp.bottom).offset(70)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        saveButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
           // $0.top.equalTo(profileEditUserProfileView.snp.bottom).offset(50)
            $0.height.equalTo(48)
        }
        

            withdrawButton.snp.makeConstraints {
                $0.centerX.equalToSuperview()
                $0.top.equalTo(saveButton.snp.bottom).offset(8)
                $0.height.equalTo(20)
            }
        
        
    }
}

extension ProfileEditViewController: ProfileEditNavigationViewDelegate {
    
    func profileEditButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
