//
//  CommentTextView.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class CommentTextView: UIView {
    
    private let dividerView = DividerView()
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
//        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 18
        imageView.clipsToBounds = true
        
        return imageView
    }()
    
    private let textViewContainer: UIView = {
        let view = UIView()
        view.backgroundColor = .gray3
        view.layer.cornerRadius = 6
        view.clipsToBounds = true
        
        return view
    }()
    
    private let textView: UITextView = {
        let textView = UITextView()
        textView.backgroundColor = .clear
        textView.font = .pretendard(.regular, size: 12)
        textView.textColor = .black
        textView.textContainerInset =  UIEdgeInsets(top: 12, left: 16, bottom: 12, right: 50)
        textView.isScrollEnabled = false
        textView.showsVerticalScrollIndicator = false
        
        return textView
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "댓글을 남겨주세요"
        label.textColor = .gray3
        label.font = .pretendard(.regular,size: 14)
        
        return label
    }()
    
    let sendButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "vector"), for: .normal)
        button.backgroundColor = .black
        button.isEnabled = false
        return button
    }()
    
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupTextView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentTextView {
    private func setupUI() {
        self.addSubviews(
            dividerView,
            profileImageView,
            textViewContainer
        )
        
        self.textViewContainer.addSubviews(
                textView,
                placeholderLabel,
                sendButton
            )
    }
    
    private func setupConstraints() {
        
//        dividerView.snp.makeConstraints {
//            $0.top.leading.trailing.equalToSuperview()
//        }
        
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(36)
            $0.leading.equalToSuperview().offset(16)
        }
        
        textViewContainer.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.top.bottom.equalToSuperview()
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.greaterThanOrEqualTo(36)
        }
        
        textView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(20)
            $0.centerY.equalToSuperview()
        }
        
        sendButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
            $0.width.greaterThanOrEqualTo(32)
        }
        
        textViewContainer.backgroundColor = .lightgray
        
    }
    
    private func setupTextView() {
        textView.delegate = self
        updateSendButtonState()
    }
    
    private func updatePlaceholder() {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    private func updateSendButtonState() {
        sendButton.isEnabled = !textView.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}

extension CommentTextView: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholder()
        updateSendButtonState()
        
//        let size = textView.sizeThatFits(CGSize(width: textView.frame.width, height: CGFloat.greatestFiniteMagnitude))
        
//        let newHeight = max(36,min(size.height,100))
//        
//        textViewContainer.snp.remakeConstraints {
//            $0.height.greaterThanOrEqualTo(newHeight)
//        }
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updatePlaceholder()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updatePlaceholder()
    }
}
