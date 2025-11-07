//
//  FreeBoardContentView.swift
//  Scently
//
//  Created by 임재현 on 8/15/25.
//

import UIKit
import SnapKit

final class FreeBoardContentView: UIView {
   
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, size: 16)
        label.textColor = .black
        label.text = "제목제목제목제목제목"
        return label
    }()
    
    private let metaInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .gray3
        label.text = "3시간전 · 조회수 999"
        
        return label
    }()
    
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .black
        label.text = "텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트"
        label.numberOfLines = 0
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FreeBoardContentView {
    private func setupUI() {
        self.addSubviews(titleLabel,subTitleLabel,metaInfoLabel)
    }
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.equalToSuperview()
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.trailing.equalToSuperview()
        }
        
        metaInfoLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(20)
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.bottom.equalToSuperview()
        }
    }
}
