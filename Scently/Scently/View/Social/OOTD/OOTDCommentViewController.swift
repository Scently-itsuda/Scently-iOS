//
//  OOTDCommentViewController.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class OOTDCommentViewController: UIViewController {
   private var headerView = OOTDCommentHeaderView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

extension OOTDCommentViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubviews(headerView)
        
    }
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
