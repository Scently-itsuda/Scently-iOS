//
//  NoticeTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 8/24/25.
//

import UIKit
import SnapKit

final class NoticeTableViewCell: UITableViewCell,ReuseIdentifying {
    
    private var titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.semiBold, size: 14)
        label.textColor = .black
        label.text = "제목제목제목제목제목"
        return label
    }()
    
    private var timeLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .gray3
        label.text = "2분전"
        return label
    }()
    
    
    private var subTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .black
        label.text = "텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트텍스트"
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NoticeTableViewCell {
    private func setupUI() {
        self.addSubviews(
            titleLabel,
            timeLabel,
            subTitleLabel
        )

        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {

        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalToSuperview().offset(16)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel.snp.centerY)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.leading)
            $0.top.equalTo(titleLabel.snp.bottom).offset(8)
            $0.trailing.equalToSuperview().offset(-16)
            $0.bottom.equalToSuperview().offset(-8)

        }

    }
}
