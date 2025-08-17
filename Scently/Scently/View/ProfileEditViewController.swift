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
            profileEditImageView
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
    }
}

extension ProfileEditViewController: ProfileEditNavigationViewDelegate {
    
    func profileEditButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
