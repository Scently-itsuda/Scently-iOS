//
//  PostContentView.swift
//  Scently
//
//  Created by 임재현 on 8/9/25.
//

import UIKit
import SnapKit

final class PostContentView: UIView {
    
    private var isExpanded = false
    private var fullText = ""
    private let maxCharacterCount = 60
    
    let userInfoLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 12)
        label.text = "여성 | 25세 | 30ML 구매"
        label.textColor = .gray3
        
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 2
        label.font = .pretendard(.regular, size: 14)
        label.textColor = .black
        label.isUserInteractionEnabled = true
        return label
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
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

extension PostContentView {
    private func setupUI() {
        self.addSubviews(userInfoLabel,contentLabel)
    }
    
    private func setupConstraints() {
        userInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(16)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelTapped))
        
        contentLabel.addGestureRecognizer(tapGesture)
        
        print("제스처 추가됨")
            print("contentLabel isUserInteractionEnabled: \(contentLabel.isUserInteractionEnabled)")
    }
    
    @objc
    func labelTapped(_ gesture: UITapGestureRecognizer) {
        let location = gesture.location(in: contentLabel)
        print("🔥 레이블 터치됨!")
        if !isExpanded {
            let labelWidth = contentLabel.bounds.width
            let labelHeight = contentLabel.bounds.height
            
            if location.x > labelWidth * 0.75 && location.y > labelHeight * 0.75 {
                toggleExpansion()
            }
        } else {
            if checkIfTappedCollapseArea(location: location) {
                toggleExpansion()
            }
        }
    }
    
    private func checkIfTappedCollapseArea(location: CGPoint) -> Bool {
        guard let attributedText = contentLabel.attributedText else {return false}
        
        let textLength = attributedText.length
        let collapseText = " 접기"
        let collapseRange = NSRange(location: textLength - collapseText.count, length: collapseText.count)
        
        let labelWidth = contentLabel.bounds.width
        let labelHeight = contentLabel.bounds.height
        
        return location.x > labelWidth * 0.8 && location.y > labelHeight * 0.8
    }
    
    private func toggleExpansion() {
        print("토글 실행! isExpanded: \(isExpanded) -> \(!isExpanded)")
        isExpanded.toggle()
        updateContentDisplay()
    }
    
    func configure(text: String) {
        fullText = text
        contentLabel.numberOfLines = 2
        contentLabel.attributedText = nil
        self.contentLabel.text = text
        isExpanded = false
        
        DispatchQueue.main.async {
            self.updateContentDisplay()
        }
    }
    
    func updateContentDisplay() {
        print("updateContentDisplay 호출, isExpanded: \(isExpanded), fullText 길이: \(fullText.count)")
        guard fullText.count > maxCharacterCount else {
            contentLabel.text = fullText
            contentLabel.numberOfLines = 0
            return
        }
        
        if !isExpanded {
            print("축약 모드")
            contentLabel.numberOfLines = 2
            contentLabel.addTrailing(with: "", moreText: " ... 더보기", moreTextFont: .pretendard(.light, size: 12), moreTextColor: .gray3)
        } else {
            print("확장 모드")
            contentLabel.numberOfLines = 0
            let fullTextWithCollapse = fullText + " 접기"
            
            let attributedString = NSMutableAttributedString(string: fullTextWithCollapse, attributes: [NSAttributedString.Key.font: contentLabel.font as Any])
            
            let collapseRange = NSRange(location: fullText.count + 1, length: 2)
            attributedString.addAttributes([
                NSAttributedString.Key.font: UIFont.pretendard(.light, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.gray3
            ], range: collapseRange)
            
            contentLabel.attributedText = attributedString
            
        }
    }
    
    func checkIfNeededMoreButton() {
  
        guard let contentTextLength = self.contentLabel.text?.count else {return}
        
        if contentTextLength > 60 {
            DispatchQueue.main.async {
                self.contentLabel.addTrailing(with: "", moreText: " ... 더보기", moreTextFont: .pretendard(.light, size: 12), moreTextColor: .gray3)
            }
        }
    }
}
