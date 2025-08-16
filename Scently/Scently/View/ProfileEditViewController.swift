//
//  ProfileEditViewController.swift
//  Scently
//
//  Created by 임재현 on 8/17/25.
//

import UIKit
import SnapKit

final class ProfileEditViewController: UIViewController {
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

extension ProfileEditViewController {
    private func setupUI() {
        self.view.backgroundColor = .systemMint
    }
    private func setupConstraints() {}
}
