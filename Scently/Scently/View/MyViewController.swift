//
//  MyViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class MyViewController: UIViewController {
        
    private var myPageHeaderView = MyPageHeaderView()
    private var myPageProfileView = MyPageProfileView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        self.view.backgroundColor = .white
        print("MyViewController init")
        myPageHeaderView.delegate = self
    }
}


extension MyViewController {
    private func setupUI() {
        self.view.addSubviews(myPageHeaderView,myPageProfileView)
    }
    private func setupConstraints() {
        myPageHeaderView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        myPageProfileView.snp.makeConstraints {
            $0.top.equalTo(myPageHeaderView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
        }
    }
}

extension MyViewController: MyPageActionDelegate {
    func alertButtonDidTap() {
        print("Alert Button Did Tapped")
    }
}
