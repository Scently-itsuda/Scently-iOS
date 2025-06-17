//
//  ReviewTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 6/17/25.
//

import UIKit
import SnapKit

class ReviewTableViewCell: UITableViewCell,ReuseIdentifiable {
    
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.backgroundColor = .lightGray
        imageView.image = UIImage(named: "icon-best-off")
        imageView.layer.cornerRadius = 16
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "김아무개"
        label.font = .pretendard(.medium, size: 12)
        label.textColor = .black
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "· 3분전"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .gray3
        return label
    }()
    
    private let starStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 2
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let ratingLabel: UILabel = {
        let label = UILabel()
        label.text = "3.5"
        label.font = .pretendard(.bold, size: 12)
           label.textColor = .black
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let userInfoLabel: UILabel = {
        let label = UILabel()
        label.text = "여성 | 25세 | 30ML구매"
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .gray3
        return label
    }()
    
    private let contentLabel: UILabel = {
        let label = UILabel()
        label.text = "안녕하세요 텍스트 후기입니다. 텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트텍스트테스트"
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .black
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        return label
    }()
    
    private let likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-best-off"), for: .normal)
        button.setTitle("12", for: .normal)
        button.setTitleColor(.gray3, for: .normal)
        button.titleLabel?.font = .pretendard(.regular, size: 12)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 4)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        button.contentHorizontalAlignment = .left
        return button
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-more"), for: .normal)
        return button
    }()

    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
        setupStarStackView()
        setLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setUI() {
        self.addSubviews(
            iconImageView,
            nicknameLabel,
            timeLabel,
            starStackView,
            ratingLabel,
            userInfoLabel,
            contentLabel,
            likeButton,
            moreButton
            
        )
    }
    
    private func setupStarStackView() {
            for _ in 0..<5 {
                let starImageView = UIImageView()
                starImageView.contentMode = .scaleAspectFit
                starImageView.image = UIImage(named: "icon-star-empty")
                starImageView.snp.makeConstraints {
                    $0.size.equalTo(16)
                }
                starStackView.addArrangedSubview(starImageView)
            }
        }
    
    
    private func setLayout() {
        iconImageView.snp.makeConstraints {
            $0.top.leading.equalToSuperview().offset(16)
            $0.size.equalTo(36)
           
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.trailing).offset(12)
            $0.top.equalTo(iconImageView.snp.top).offset(4)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.trailing).offset(4)
            $0.top.equalTo(nicknameLabel)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        starStackView.snp.makeConstraints {
            $0.leading.equalTo(nicknameLabel.snp.leading)
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(4)
        }
        
        ratingLabel.snp.makeConstraints {
            $0.leading.equalTo(starStackView.snp.trailing).offset(4)
            $0.centerY.equalTo(starStackView.snp.centerY)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        userInfoLabel.snp.makeConstraints {
            $0.leading.equalTo(iconImageView.snp.leading)
            $0.top.equalTo(iconImageView.snp.bottom).offset(16)
        }
        
        contentLabel.snp.makeConstraints {
            $0.leading.equalTo(userInfoLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-16)
            $0.top.equalTo(userInfoLabel.snp.bottom).offset(8)
        }
        
        likeButton.snp.makeConstraints {
            $0.leading.equalTo(contentLabel.snp.leading)
            $0.top.equalTo(contentLabel.snp.bottom).offset(12)
            $0.height.equalTo(20)
            $0.bottom.equalToSuperview().offset(-16)
        }
           

        likeButton.imageView?.snp.makeConstraints {
            $0.size.equalTo(20)
        }
        
        moreButton.snp.makeConstraints {
            $0.centerY.equalTo(iconImageView.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
        }
    }
    
    func configure(nickname: String, createdAt: String, rating: Double) {
        nicknameLabel.text = nickname
        timeLabel.text = " · 3분전"
        ratingLabel.text = String(format: "%.1f", rating)
        updateStarRating(rating: rating)
    }
    
    private func updateStarRating(rating: Double) {
        for (index, starView) in starStackView.arrangedSubviews.enumerated() {
            guard let starImageView = starView as? UIImageView else { continue }
            
            if Double(index) < rating.rounded(.down) {
 
                starImageView.image = UIImage(named: "icons-star-fill")
            } else if Double(index) < rating && rating.truncatingRemainder(dividingBy: 1) >= 0.5 {
      
                starImageView.image = UIImage(named: "icon-half star")
            } else {
            
                starImageView.image = UIImage(named: "icon-star-empty")
            }
        }
    }
}
