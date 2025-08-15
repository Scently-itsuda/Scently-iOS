//
//  CommentInteractionView.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class CommentInteractionView: UIView {
    
    private let thumbsUpContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let commentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let thumbsUpButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-best-off"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let thumbsUpCountLabel: UILabel = {
        let label = UILabel()
        label.text = "9999"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .black
        return label
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-comment"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let commentTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "답글달기"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .black
        return label
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "4"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .gray3
        return label
    }()
    
    var onLikeButtonTapped: (()->Void)?
    var onCommentButtonTapped: (()->Void)?

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


extension CommentInteractionView {
    private func setupUI() {
        self.addSubviews(thumbsUpContainerView,commentContainerView)
        self.thumbsUpContainerView.addSubviews(thumbsUpButton,thumbsUpCountLabel)
        self.commentContainerView.addSubviews(commentButton,commentTitleLabel,commentCountLabel)
    }
    private func setupConstraints() {
        thumbsUpContainerView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.height.equalTo(16)
        }
        
        thumbsUpButton.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        
        thumbsUpCountLabel.snp.makeConstraints {
            $0.leading.equalTo(thumbsUpButton.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        commentContainerView.snp.makeConstraints {
            $0.leading.equalTo(thumbsUpContainerView.snp.trailing).offset(8)
            $0.top.bottom.trailing.equalToSuperview()
            $0.height.equalTo(16)
            
        }
        
        commentButton.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
        commentTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(commentButton.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.leading.equalTo(commentTitleLabel.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    private func setupGesture() {
        let thumbsUpTapGesture = UITapGestureRecognizer(target: self, action: #selector(thumbsUpContainerTapped))
        
        thumbsUpContainerView.addGestureRecognizer(thumbsUpTapGesture)
        
        
        let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(commentContainerTapped))
        
        commentContainerView.addGestureRecognizer(commentTapGesture)
    }
    
    
    @objc
    private func thumbsUpContainerTapped() {
        onLikeButtonTapped?()
    }
    
    @objc
    private func commentContainerTapped() {
        onCommentButtonTapped?()
    }
}
