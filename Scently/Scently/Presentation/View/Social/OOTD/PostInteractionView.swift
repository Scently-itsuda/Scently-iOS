//
//  PostInteractionView.swift
//  Scently
//
//  Created by 임재현 on 8/9/25.
//

import UIKit
import SnapKit

final class PostInteractionView: UIView {
    
    private let likeContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let commentContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-like-#12"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let likeCountLabel: UILabel = {
        let label = UILabel()
        label.text = "9999"
        label.font = .pretendard(.medium, size: 14)
        label.textColor = .black
        return label
    }()
    
    private let commentButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-comment"), for: .normal)
        button.isUserInteractionEnabled = false
        return button
    }()
    
    private let commentCountLabel: UILabel = {
        let label = UILabel()
        label.text = "9999"
        label.font = .pretendard(.medium, size: 14)
        label.textColor = .black
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


extension PostInteractionView {
    private func setupUI() {
        self.addSubviews(likeContainerView,commentContainerView)
        self.likeContainerView.addSubviews(likeButton,likeCountLabel)
        self.commentContainerView.addSubviews(commentButton,commentCountLabel)
    }
    private func setupConstraints() {
        likeContainerView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.height.equalTo(80)
        }
        
        likeButton.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.leading.equalTo(likeButton.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
        
        commentContainerView.snp.makeConstraints {
            $0.leading.equalTo(likeContainerView.snp.trailing).offset(8)
            $0.top.bottom.trailing.equalToSuperview()
            $0.height.equalTo(80)
            
        }
        
        commentButton.snp.makeConstraints {
            $0.leading.centerY.equalToSuperview()
            $0.size.equalTo(24)
        }
        
        commentCountLabel.snp.makeConstraints {
            $0.leading.equalTo(commentButton.snp.trailing).offset(4)
            $0.centerY.equalToSuperview()
            $0.trailing.lessThanOrEqualToSuperview()
        }
    }
    
    private func setupGesture() {
        let likeTapGesture = UITapGestureRecognizer(target: self, action: #selector(likeContainerTapped))
        
        likeContainerView.addGestureRecognizer(likeTapGesture)
        
        
        let commentTapGesture = UITapGestureRecognizer(target: self, action: #selector(commentContainerTapped))
        
        commentContainerView.addGestureRecognizer(commentTapGesture)
    }
    
    
    @objc
    private func likeContainerTapped() {
        onLikeButtonTapped?()
    }
    
    @objc
    private func commentContainerTapped() {
        onCommentButtonTapped?()
    }
}

extension PostInteractionView {
    func configure(likeCount: Int,commentCount: Int, isLiked: Bool) {
        
        let likeCount = String(likeCount)
        let commentCount = String(commentCount)
        
        self.likeCountLabel.text = likeCount
        self.commentCountLabel.text = commentCount
        
        let buttonImage = isLiked ? 
        "icon-like-#12 1" : "icon-nav-like-off"
        
        self.likeButton.setImage(UIImage(named: buttonImage), for: .normal)
    }
}
