//
//  ReviewListTableViewCell.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit
import SnapKit

final class ReviewListTableViewCell: UITableViewCell, ReuseIdentifying {
    
    private let profileImageView = UIImageView()
    private let nicknameLabel = UILabel()
    private let timeLabel = UILabel()
    private let ratingStackView = UIStackView()
    private let ratingValueLabel = UILabel()
    private let moreButton = UIButton()
    
    private let productNameLabel = UILabel()
    private let brandLabel = UILabel()
    private let contentLabel = UILabel()
    
    private let infoLabel = UILabel()
    private let likeButton = UIButton()
    private let likeCountLabel = UILabel()
    
    // MARK: - Init
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
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
        
        nicknameLabel.text = "김아무개"
        timeLabel.text = "2분전"
        ratingValueLabel.text = "3"
        productNameLabel.text = "미스 디올 오 드 퍼퓸"
        brandLabel.text = "미스 디올"
        contentLabel.text = "미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸미스 디올 오 드 퍼퓸"
        infoLabel.text = "남자 | 34세 | 30ML구매"
        likeCountLabel.text = "999+"
    }
}

private extension ReviewListTableViewCell {
    func setupUI() {
        // 프로필 이미지
        profileImageView.backgroundColor = .lightGray
        profileImageView.layer.cornerRadius = 20
        profileImageView.clipsToBounds = true
        
        // 닉네임
        nicknameLabel.font = .systemFont(ofSize: 14, weight: .semibold)
        
        // 시간
        timeLabel.font = .systemFont(ofSize: 12)
        timeLabel.textColor = .gray
        
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
        ratingValueLabel.font = .systemFont(ofSize: 14)
        
        // 더보기
        moreButton.setImage(UIImage(systemName: "ellipsis"), for: .normal)
        moreButton.tintColor = .black
        
        // 향수 이름
        productNameLabel.font = .boldSystemFont(ofSize: 16)
        
        // 브랜드
        brandLabel.font = .systemFont(ofSize: 12)
        brandLabel.textColor = .gray
        
        // 내용
        contentLabel.font = .systemFont(ofSize: 14)
        contentLabel.numberOfLines = 2
        
        // 성별/연령/용량
        infoLabel.font = .systemFont(ofSize: 13)
        infoLabel.textColor = .gray
        
        // 좋아요
        likeButton.setImage(UIImage(systemName: "hand.thumbsup.fill"), for: .normal)
        likeButton.tintColor = .black
        likeCountLabel.font = .systemFont(ofSize: 13)
        
        contentView.addSubviews([
            profileImageView, nicknameLabel, timeLabel, ratingStackView, ratingValueLabel,
            moreButton, productNameLabel, brandLabel, contentLabel,
            infoLabel, likeButton, likeCountLabel
        ])
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().inset(16)
            $0.size.equalTo(40)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(profileImageView)
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
        
        ratingStackView.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
        }
        
        ratingValueLabel.snp.makeConstraints {
            $0.centerY.equalTo(ratingStackView)
            $0.leading.equalTo(ratingStackView.snp.trailing).offset(4)
        }
        
        productNameLabel.snp.makeConstraints {
            $0.top.equalTo(ratingStackView.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
        }
        
        brandLabel.snp.makeConstraints {
            $0.centerY.equalTo(productNameLabel)
            $0.leading.equalTo(productNameLabel.snp.trailing).offset(6)
        }
        
        contentLabel.snp.makeConstraints {
            $0.top.equalTo(productNameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        infoLabel.snp.makeConstraints {
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
            $0.leading.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(12)
        }
        
        likeButton.snp.makeConstraints {
            $0.centerY.equalTo(infoLabel)
            $0.trailing.equalToSuperview().inset(40)
            $0.size.equalTo(20)
        }
        
        likeCountLabel.snp.makeConstraints {
            $0.centerY.equalTo(likeButton)
            $0.leading.equalTo(likeButton.snp.trailing).offset(4)
        }
    }
}
