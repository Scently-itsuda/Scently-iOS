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
    
    
    private let contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .pretendard(.regular, size: 14)
        textView.textColor = .black
        textView.backgroundColor = .clear
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.textContainer.lineFragmentPadding = 0
        textView.textContainerInset = .zero
        textView.textContainer.lineBreakMode = .byTruncatingTail
        textView.textContainer.maximumNumberOfLines = 2
        return textView
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
     //   setupGesture()
        setupTextViewDelegate()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PostContentView {
    private func setupUI() {
        self.addSubviews(userInfoLabel,contentTextView)
    }
    
    private func setupConstraints() {
        userInfoLabel.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide)
            $0.leading.equalToSuperview().inset(16)
        }
        
        contentTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(8)
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setupTextViewDelegate() {
          contentTextView.delegate = self
      }
        
    private func toggleExpansion() {
        print("토글 실행! isExpanded: \(isExpanded) -> \(!isExpanded)")
        isExpanded.toggle()
        updateContentDisplay()
    }
    
    func configure(text: String) {
        fullText = text
        isExpanded = false
        
        DispatchQueue.main.async {
            self.updateContentDisplay()
        }
    }
    
    private func updateContentDisplay() {
        print("updateContentDisplay 호출, isExpanded: \(isExpanded), fullText 길이: \(fullText.count)")
        
        guard fullText.count > maxCharacterCount else {
            contentTextView.textContainer.maximumNumberOfLines = 0
            contentTextView.text = fullText
            contentTextView.linkTextAttributes = [:]
            return
        }
        
        if !isExpanded {
            print("축약 모드")
            contentTextView.textContainer.maximumNumberOfLines = 2
            
            let truncatedText = createTruncatedText()
            let attributedString = NSMutableAttributedString(string: truncatedText, attributes: [
                NSAttributedString.Key.font: contentTextView.font ?? UIFont.systemFont(ofSize: 14)
            ])
            
            // "더보기" 링크 추가
            let moreText = " ... 더보기"
            let moreRange = NSRange(location: truncatedText.count - moreText.count, length: moreText.count)
            
            attributedString.addAttributes([
                NSAttributedString.Key.font: UIFont.pretendard(.light, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.gray3,
                NSAttributedString.Key.link: "more://"
            ], range: moreRange)
            
            contentTextView.attributedText = attributedString
            
        } else {
            print("확장 모드")
            contentTextView.textContainer.maximumNumberOfLines = 0
            
            let fullTextWithCollapse = fullText + " 접기"
            let attributedString = NSMutableAttributedString(string: fullTextWithCollapse, attributes: [
                NSAttributedString.Key.font: contentTextView.font ?? UIFont.systemFont(ofSize: 14)
            ])
            
            // "접기" 링크 추가
            let collapseRange = NSRange(location: fullText.count + 1, length: 2)
            attributedString.addAttributes([
                NSAttributedString.Key.font: UIFont.pretendard(.light, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.gray3,
                NSAttributedString.Key.link: "collapse://"
            ], range: collapseRange)
            
            contentTextView.attributedText = attributedString
        }
        
        // 링크 스타일 설정
        contentTextView.linkTextAttributes = [
            NSAttributedString.Key.underlineStyle: 0  // 밑줄 제거
        ]
    }
    
    private func createTruncatedText() -> String {
        let maxLength = maxCharacterCount
        let moreText = " ... 더보기"
        
        if fullText.count <= maxLength {
            return fullText + moreText
        }
        
        let truncateLength = maxLength - moreText.count
        let truncatedContent = String(fullText.prefix(truncateLength))
        return truncatedContent + moreText
    }
}

extension PostContentView: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "more" {
            print("더보기 터치됨!")
            toggleExpansion()
            return false
        } else if URL.scheme == "collapse" {
            print("접기 터치됨!")
            toggleExpansion()
            return false
        }
        
        return false
    }
}
