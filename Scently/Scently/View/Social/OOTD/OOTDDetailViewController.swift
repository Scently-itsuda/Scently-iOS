//
//  OOTDDetailViewController.swift
//  Scently
//
//  Created by 임재현 on 8/8/25.
//

import UIKit
import SnapKit

final class OOTDDetailViewController: UIViewController {
    
    private var navigationView = OOTDNavigationView()
    
    private let perfumeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "미스 디올 오 드 퍼퓸"
        label.font = .pretendard(.bold, size: 16)
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        setupUI()
        setupConstraint()
        
        navigationView.delegate = self
    }
    
    private func setupUI() {
        self.view.addSubviews(navigationView,perfumeTitleLabel)
    }
    
    private func setupConstraint() {
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        perfumeTitleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
        }
    }
    
    func configure(num: String) {
        self.perfumeTitleLabel.text = num
    }
}

extension OOTDDetailViewController: OOTDNavigationViewDelegate {

    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapAlertButton() {
        print("VC에서 alertButton 동작 전달받음")
    }
}
