//
//  OOTDCommentHeaderView.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class OOTDCommentHeaderView: UIView {
    
    private let commentLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글"
        label.textColor = .black
        label.font = .pretendard(.medium, size: 14)
        
        return label
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "11"
        label.textColor = .gray3
        label.font = .pretendard(.medium, size: 14)
        
        return label
    }()
    
    private let dividerView = DividerView()
 
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension OOTDCommentHeaderView {
    private func setupUI() {
        self.addSubviews(
                commentLabel,
                commentCountLabel,
                dividerView
            )
    }
    
    private func setupConstraints() {
        commentLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.top)
            $0.leading.equalTo(commentLabel.snp.trailing).offset(4)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(commentLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
        }
    }
}
