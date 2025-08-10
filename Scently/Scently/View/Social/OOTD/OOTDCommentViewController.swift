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
    private var commentListView = CommentListView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

extension OOTDCommentViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubviews(headerView,commentListView)
        
    }
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        commentListView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
        }
    }
}
