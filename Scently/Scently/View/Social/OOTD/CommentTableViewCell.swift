//
//  CommentTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class CommentTableViewCell: UITableViewCell,ReuseIdentifying {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    private var userProfileView = OOTDDetailUserProfileView()
    
    private var contentLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .black
        label.text = "텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스텍스트텍트스"
        label.numberOfLines = 0
        
        return label
    }()
    
    private var commentInteractionView = CommentInteractionView()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

extension CommentTableViewCell {
    private func setupUI() {
        self.addSubviews(
            containerView,
            userProfileView,
            contentLabel,
            commentInteractionView
        )
        
        userProfileView.configureForComment()

        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        
        userProfileView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }
        
        commentInteractionView.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(8)
            $0.leading.equalToSuperview().offset(20)
            $0.bottom.equalToSuperview().offset(-12)
        }
    }
    
    func configure(with item: CommentDisplayItem) {

        let additionalOffset: CGFloat = item.isChild ? 20 : 0
        
        userProfileView.snp.updateConstraints {
            $0.leading.equalToSuperview().inset(16 + additionalOffset)
            $0.trailing.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.updateConstraints {
            $0.leading.equalToSuperview().inset(20 + additionalOffset)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        commentInteractionView.snp.updateConstraints {
            $0.leading.equalToSuperview().offset(20 + additionalOffset)
        }

        switch item.type {
        case .parent(let commentInfo):
            contentLabel.text = commentInfo.content
            
        case .child(let childInfo):
            contentLabel.text = childInfo.content
        }
    }
}

