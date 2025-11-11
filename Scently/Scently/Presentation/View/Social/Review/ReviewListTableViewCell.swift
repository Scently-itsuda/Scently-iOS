//
//  ReviewListTableViewCell.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit
import SnapKit

protocol ReviewCellDelegate: AnyObject {
    func moreButtonTapped(isMyReview: Bool)
}

final class ReviewListTableViewCell: UITableViewCell, ReuseIdentifying {
    
    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let timeLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let ratingValueLabel = UILabel()
    private let moreButton = UIButton()
    private let perfumeImageView = UIImageView()
    
    private let productNameLabel = UILabel()
    private let brandLabel = UILabel()
    private let productInfoContainerView = UIView()
    private let leftBorderView = UIView()
    private let contentLabel = UILabel()
    
    private let contentTextView = UITextView()
    private var isExpanded = false
    private var fullText = ""
    private let maxCharacterCount = 70
    
    private let infoLabel = UILabel()
    private let likeButton = UIButton()
    private let likeCountLabel = UILabel()
    
    weak var delegate: ReviewCellDelegate?
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        setAddTargets()
        configure()
    }
    
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configure() {
        //func configure(review: ReviewModel)
        /**
        nicknameLabel.text = review.nickname
        timeLabel.text = review.timeAgo
        ratingValueLabel.text = "\(review.rating)"
        productNameLabel.text = review.productName
        brandLabel.text = review.brandName
        contentLabel.text = review.content
        infoLabel.text = "\(review.gender) | \(review.age) | \(review.capacity)"
        likeCountLabel.text = "\(review.likeCount)+"
         */
        
        let longText = "미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼"
        
        configureContent(text: longText)
        
        nicknameLabel.text = "김아무개"
        timeLabel.text = "· 2분전"
        ratingValueLabel.text = "3"
        productNameLabel.text = "미스 디올 오 드 퍼퓸"
        brandLabel.text = "미스 디올"
        contentLabel.text = "미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸"
        infoLabel.text = "남자 | 34세 | 30ML구매"
        likeCountLabel.text = "999+"
    }
    
    private func configureContent(text: String) {
        fullText = text
        isExpanded = false
        updateContentDisplay()
    }
    
    private func updateContentDisplay() {
        guard fullText.count > maxCharacterCount else {
            contentTextView.text = fullText
            contentTextView.textContainer.maximumNumberOfLines = 0
            contentTextView.linkTextAttributes = [:]
            return
        }
        
        if !isExpanded {
            // 축약 모드
            contentTextView.textContainer.maximumNumberOfLines = 2
            
            let truncatedText = createTruncatedText()
            let attributedString = NSMutableAttributedString(string: truncatedText, attributes: [
                NSAttributedString.Key.font: contentTextView.font ?? UIFont.pretendard(.regular, size: 12)
            ])
            
            let moreText = " ... 더보기"
            let moreRange = NSRange(location: truncatedText.count - moreText.count, length: moreText.count)
            
            attributedString.addAttributes([
                NSAttributedString.Key.font: UIFont.pretendard(.regular, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                NSAttributedString.Key.link: "more://"
            ], range: moreRange)
            
            contentTextView.attributedText = attributedString
            
        } else {
            // 확장 모드
            contentTextView.textContainer.maximumNumberOfLines = 0
            
            let fullTextWithCollapse = fullText + " 접기"
            let attributedString = NSMutableAttributedString(string: fullTextWithCollapse, attributes: [
                NSAttributedString.Key.font: contentTextView.font ?? UIFont.pretendard(.regular, size: 12)
            ])
            
            let collapseRange = NSRange(location: fullText.count + 1, length: 2)
            attributedString.addAttributes([
                NSAttributedString.Key.font: UIFont.pretendard(.regular, size: 12),
                NSAttributedString.Key.foregroundColor: UIColor.systemGray,
                NSAttributedString.Key.link: "collapse://"
            ], range: collapseRange)
            
            contentTextView.attributedText = attributedString
        }
        
        contentTextView.linkTextAttributes = [NSAttributedString.Key.underlineStyle: 0]
    }
    
    private func createTruncatedText() -> String {
        let moreText = " ... 더보기"
        let maxLength = maxCharacterCount
        
        if fullText.count <= maxLength {
            return fullText + moreText
        }
        
        let truncateLength = maxLength - moreText.count
        let truncatedContent = String(fullText.prefix(truncateLength))
        return truncatedContent + moreText
    }
    
    private func toggleExpansion() {
        isExpanded.toggle()
        updateContentDisplay()
        
        // 셀 높이 업데이트를 위해 테이블뷰에 알림
        if let tableView = superview as? UITableView {
            tableView.beginUpdates()
            tableView.endUpdates()
        }
    }
}

private extension ReviewListTableViewCell {
    func setupUI() {
        // 프로필 이미지
        profileImageView.backgroundColor = .lightgray
        profileImageView.layer.cornerRadius = 18
        profileImageView.clipsToBounds = true
        
        // 닉네임
        nicknameLabel.font = .pretendard(.medium, size: 12)
        nicknameLabel.textColor = .black
        nicknameLabel.numberOfLines = 1
        
        // 시간
        timeLabel.font = .pretendard(.regular, size: 10)
        timeLabel.textColor = .gray3
//        timeLabel.numberOfLines = 1
        
        // 별점
        ratingStackView.axis = .horizontal
        ratingStackView.spacing = 2
        for _ in 0..<5 {
            let star = UIImageView(image: UIImage(systemName: "star.fill"))
            star.tintColor = .orange
            star.snp.makeConstraints { $0.size.equalTo(12) }
            ratingStackView.addArrangedSubview(star)
        }
        
        // 평점 숫자
        ratingValueLabel.font = .pretendard(.bold, size: 10)
        ratingValueLabel.textColor = .black
        
        // 더보기
        moreButton.setImage(UIImage(named: "icon-more"), for: .normal)
//        moreButton.tintColor = .black
        
        perfumeImageView.image = UIImage(named: "perfume")
        
        // 향수 이름
        productNameLabel.font = .pretendard(.bold, size: 14)
        productNameLabel.textColor = .black
        
        // 브랜드
        brandLabel.font = .pretendard(.light, size: 10)
        brandLabel.textColor = .gray3
        
        // 내용
        contentLabel.font = .pretendard(.regular, size: 12)
        contentLabel.numberOfLines = 2
        contentLabel.textColor = .black
        
        contentTextView.font = .pretendard(.regular, size: 12)
        contentTextView.textColor = .black
        contentTextView.backgroundColor = .clear
        contentTextView.isEditable = false
        contentTextView.isScrollEnabled = false
        contentTextView.textContainer.lineFragmentPadding = 0
        contentTextView.textContainerInset = .zero
        contentTextView.textContainer.lineBreakMode = .byCharWrapping
        contentTextView.textContainer.maximumNumberOfLines = 3
        contentTextView.delegate = self
        
        // 성별/연령/용량
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textColor = .gray
        
        // 좋아요
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        likeButton.tintColor = .black
        likeCountLabel.font = .systemFont(ofSize: 13)
        
        productInfoContainerView.addSubviews(leftBorderView,productNameLabel,brandLabel)
        
        contentView.addSubviews(
            profileImageView, nicknameLabel, timeLabel, ratingStackView, ratingValueLabel,
            moreButton, productInfoContainerView, contentLabel,
            infoLabel, likeButton, likeCountLabel,perfumeImageView,contentTextView
        )
    }
    
    func setupConstraints() {
        
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(36)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView).offset(4)
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
        }
        
        timeLabel.snp.makeConstraints {
            $0.centerY.equalTo(nicknameLabel)
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(4)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(profileImageView)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        perfumeImageView.snp.makeConstraints {
            $0.size.equalTo(72)
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.trailing.equalToSuperview().offset(-16)
        }
        
        ratingStackView.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
        }
        
        ratingValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingStackView)
            $0.leading.equalTo(ratingStackView.snp.trailing).offset(4)
        }
        
        productInfoContainerView.snp.makeConstraints {
            $0.top.equalTo(profileImageView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.equalTo(perfumeImageView.snp.leading).offset(-8)
            $0.height.equalTo(28)
        }
        
        productInfoContainerView.backgroundColor = .lightgray
        productInfoContainerView.layer.cornerRadius = 6
        
        leftBorderView.snp.makeConstraints {
            $0.top.bottom.equalToSuperview()
            $0.leading.equalToSuperview()
            $0.width.equalTo(2)
        }
        
        leftBorderView.backgroundColor = .black
        
        productNameLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.equalToSuperview().offset(8)
        }
        
        brandLabel.snp.makeConstraints {
            $0.centerY.equalTo(productNameLabel)
            $0.leading.equalTo(productNameLabel.snp.trailing).offset(6)
        }
     
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(productInfoContainerView.snp.bottom).offset(8)
            $0.leading.equalToSuperview().inset(16)
            $0.trailing.lessThanOrEqualTo(perfumeImageView.snp.leading).offset(-8)
        }

        selectionStyle = .none

        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel)
            $0.trailing.equalToSuperview().inset(56)
            $0.size.equalTo(20)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(4)
        }
    }
    
    private func setAddTargets() {
        moreButton.addTarget(self, action: #selector(moreButtonDidTap), for: .touchUpInside)
    }
    
    @objc func moreButtonDidTap() {
        delegate?.moreButtonTapped(isMyReview: true)
    }
}

extension ReviewListTableViewCell: UITextViewDelegate {
    func textView(_ textView: UITextView, shouldInteractWith URL: URL, in characterRange: NSRange, interaction: UITextItemInteraction) -> Bool {
        
        if URL.scheme == "more" {
            toggleExpansion()
            return false
        } else if URL.scheme == "collapse" {
            toggleExpansion()
            return false
        }
        
        return false
    }
}
