//
//  MyPageHeaderView.swift
//  Scently
//
//  Created by 임재현 on 8/16/25.
//

import UIKit
import SnapKit

protocol MyPageActionDelegate: AnyObject {
    func alertButtonDidTap()
}

final class MyPageHeaderView: UIView {
    
    weak var delegate: MyPageActionDelegate?
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "마이페이지"
        label.textColor = .black
        label.font = .pretendard(.bold, size: 20)
        
        return label
    }()
    
    private let alertButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-bell2"), for: .normal)
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setAddTarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension MyPageHeaderView {
    
    private func setupUI() {
        
        self.addSubviews(titleLabel,alertButton)
        
    }
    
    private func setupConstraints() {
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        alertButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
    }
    
    private func setAddTarget() {
        alertButton.addTarget(self, action: #selector(alertButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func alertButtonDidTap() {
        delegate?.alertButtonDidTap()
    }
}
