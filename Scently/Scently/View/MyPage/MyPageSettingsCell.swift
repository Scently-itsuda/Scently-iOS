//
//  MyPageSettingsCell.swift
//  Scently
//
//  Created by 임재현 on 8/17/25.
//

import UIKit
import SnapKit

class MyPageSettingsCell: UITableViewCell,ReuseIdentifying {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let rightArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon-enter")
        imageView.tintColor = .black
        return imageView
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = .white
        selectionStyle = .none
        
        self.addSubviews(titleLabel, rightArrowView)
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightArrowView.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
    }
    
    func configure(title: String) {
        titleLabel.text = title
    }
}
