//
//  FreeBoardTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 8/15/25.
//

import UIKit
import SnapKit

final class FreeBoardTableViewCell: UITableViewCell,ReuseIdentifying {
    
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
    
    private let viewsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon_view_count")
        
        return imageView
    }()
    
    private let viewsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .gray3
        return label
    }()
    
    private let commentsImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icons8-댓글-96 1")
        
        return imageView
    }()
    
    private let commentsCountLabel: UILabel = {
        let label = UILabel()
        label.text = "00"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .gray3
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

extension FreeBoardTableViewCell {
    private func setupUI() {
        self.addSubviews(
            titleLabel,
            timeLabel,
            subTitleLabel,
            viewsImageView,
            viewsCountLabel,
            commentsImageView,
            commentsCountLabel
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

        }
        
        viewsImageView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(16)
        }
        
        viewsCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(viewsImageView.snp.centerY)
            $0.leading.equalTo(viewsImageView.snp.trailing).offset(4)
        }
        
        commentsImageView.snp.makeConstraints {
            $0.top.equalTo(viewsImageView.snp.top)
            $0.leading.equalTo(viewsCountLabel.snp.trailing).offset(8)
            $0.size.equalTo(16)
        }
        
        commentsCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(commentsImageView.snp.centerY)
            $0.leading.equalTo(commentsImageView.snp.trailing).offset(4)
            $0.bottom.equalToSuperview().offset(-16)
        }

    }
}
