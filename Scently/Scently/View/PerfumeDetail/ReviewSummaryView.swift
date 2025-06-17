//
//  ReviewSummaryView.swift
//  Scently
//
//  Created by 임재현 on 6/17/25.
//

import UIKit
import SnapKit

final class ReviewSummaryView: UIView {
    
    private let reviewIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon-perfume")
        return imageView
    }()
    
    private let reviewLabel : UILabel = {
        let label = UILabel()
        label.text = "리뷰 모아보기 (123456)"
        label.font = .pretendard(.bold, size: 13)
        label.textColor = .black
        return label
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("인기순", for: .normal)
        button.setImage(UIImage(named: "icon-updown"), for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 12)
        button.setTitleColor(.gray3, for: .normal)
        button.tintColor = .gray3
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    
    private let dividerView = DividerView(backgroundColor: .gray4,height: 1)
    
    private lazy var ratingStackView = createRatingView()
    
    private let verticalDividerView = DividerView(
        backgroundColor: .gray4,
        height: 1,
        axis: .vertical
    )
    
    private let dividerView2 = DividerView(backgroundColor: .gray4,height: 1)
    
    private lazy var ratingBreakdownView = createRatingBreakdownView()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
        configureReviewLabel(count: 111)
        print("ReviewSummaryView created")
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        print("ReviewSummaryView frame: \(self.frame)")
    }
    
    private func setupUI() {
        self.addSubviews(
            reviewIconImage,
            reviewLabel,
            sortButton,
            dividerView,
            ratingStackView,
            verticalDividerView,
            dividerView2,
            ratingBreakdownView
        )
    }
    
    private func setupLayout() {
        
        reviewIconImage.snp.makeConstraints {
            $0.top.equalToSuperview().offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(20)
        }
        
        reviewLabel.snp.makeConstraints {
            $0.leading.equalTo(reviewIconImage.snp.trailing).offset(4)
            $0.centerY.equalTo(reviewIconImage.snp.centerY)
            $0.trailing.lessThanOrEqualToSuperview().offset(-16)
        }
        
        sortButton.snp.makeConstraints {
            $0.centerY.equalTo(reviewIconImage.snp.centerY)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(47)
            $0.height.equalTo(14)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(reviewIconImage.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
           
        }
        
        ratingStackView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(51)
            $0.leading.equalToSuperview().offset(45)
        }
        
        verticalDividerView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(12)
            $0.leading.equalTo(ratingStackView.snp.trailing).offset(30)
            $0.bottom.equalTo(dividerView2.snp.top).offset(-12)

        }
        
        dividerView2.snp.makeConstraints {
            $0.top.equalTo(ratingStackView.snp.bottom).offset(51)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview().offset(-16)
        }
        
        ratingBreakdownView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.leading.equalTo(verticalDividerView.snp.trailing).offset(20)
            $0.trailing.equalToSuperview().offset(-20)
            $0.bottom.equalTo(dividerView2.snp.top).offset(-20)
        }
    }
    
    func configureReviewLabel(count: Int) {
        let mainText = "리뷰 모아보기"
        let countText = " (\(count.formatted()))"
        
        let attributedString = NSMutableAttributedString(
            string: mainText + countText,
            attributes: [
                .font: UIFont.pretendard(.bold, size: 13),
                .foregroundColor: UIColor.black
            ]
        )

        let countRange = NSRange(location: mainText.count, length: countText.count)
        attributedString.addAttributes([
            .foregroundColor: UIColor.gray,
            .font: UIFont.pretendard(.medium, size: 13)
        ], range: countRange)
        
        reviewLabel.attributedText = attributedString
    }
    
    private func createRatingView() -> UIView {
        let containerStack = UIStackView()
        containerStack.axis = .vertical
        containerStack.spacing = 4
        containerStack.alignment = .center
        
        let scoreLabel = UILabel()
        
        let attributedString = NSMutableAttributedString()
        attributedString.append(NSAttributedString(
            string: "3.5 ",
            attributes: [
                .font: UIFont.pretendard(.bold, size: 24),
                .foregroundColor: UIColor.black
            ]
        ))
        attributedString.append(NSAttributedString(
            string: "/5",
            attributes: [
                .font: UIFont.pretendard(.regular, size: 16),
                .foregroundColor: UIColor.gray
            ]
        ))
        
        scoreLabel.attributedText = attributedString
        
        let starStack = UIStackView()
            starStack.axis = .horizontal
            starStack.spacing = 2
            
            for i in 0..<5 {
                let starImageView = UIImageView()
                starImageView.contentMode = .scaleAspectFit
                starImageView.snp.makeConstraints { $0.size.equalTo(16) }
                
                if i < 3 {
                    starImageView.image = UIImage(named: "icons-star-fill")
                } else if i == 3 {
                    starImageView.image = UIImage(named: "icon-half star")
                } else {
                    starImageView.image = UIImage(named: "icon-star-empty")
                }
                
                starStack.addArrangedSubview(starImageView)
            }
        
        containerStack.addArrangedSubview(scoreLabel)
        containerStack.addArrangedSubview(starStack)
        
        return containerStack
    }
    
    private func getDummyCount(for rating: Int) -> Int {
        switch rating {
        case 5: return 450
        case 4: return 300
        case 3: return 150
        case 2: return 70
        case 1: return 30
        default: return 0
        }
    }
    
    private func createRatingBreakdownView() -> UIView {
        let containerStack = UIStackView()
        containerStack.axis = .vertical
        containerStack.spacing = 8
        containerStack.distribution = .fillEqually
        
        for rating in (1...5).reversed() {
            let horizontalStack = createRatingRowView(
                rating: rating,
                count: getDummyCount(for: rating),
                totalReviews: 1000
            )
            containerStack.addArrangedSubview(horizontalStack)
        }
        
        return containerStack
    }
    
    private func createRatingRowView(rating: Int, count: Int, totalReviews: Int) -> UIView {
        let horizontalStack = UIStackView()
        horizontalStack.axis = .horizontal
        horizontalStack.spacing = 8
        horizontalStack.alignment = .center
        horizontalStack.distribution = .fill
        
        let scoreLabel = UILabel()
        scoreLabel.text = "\(rating)점"
        scoreLabel.font = .pretendard(.medium, size: 12)
        scoreLabel.textColor = .black
        scoreLabel.textAlignment = .center
        scoreLabel.snp.makeConstraints {
            $0.width.equalTo(30)
        }
        
        let progressContainer = createCustomProgressView(count: count, totalReviews: totalReviews)
        
        let countLabel = UILabel()
        countLabel.text = "\(count)명"
        countLabel.font = .pretendard(.regular, size: 11)
        countLabel.textColor = .gray3
        countLabel.textAlignment = .right
        countLabel.snp.makeConstraints {
            $0.width.equalTo(40)
        }
        
        horizontalStack.addArrangedSubview(scoreLabel)
        horizontalStack.addArrangedSubview(progressContainer)
        horizontalStack.addArrangedSubview(countLabel)
        
        return horizontalStack
    }

    private func createCustomProgressView(count: Int, totalReviews: Int) -> UIView {
        let container = UIView()
        
        let backgroundView = UIView()
        backgroundView.backgroundColor = .gray4
        backgroundView.layer.cornerRadius = 4
        
        let progressView = UIView()
        progressView.backgroundColor = .systemOrange
        progressView.layer.cornerRadius = 4
        
        container.addSubview(backgroundView)
        container.addSubview(progressView)
        
        container.snp.makeConstraints {
            $0.height.equalTo(8)
            $0.width.equalTo(116)
        }
        
        backgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // 진행률 계산
        let progress = totalReviews > 0 ? Double(count) / Double(totalReviews) : 0
        let progressWidth = 116 * progress
        
        progressView.snp.makeConstraints {
            $0.leading.top.bottom.equalToSuperview()
            $0.width.equalTo(max(8, progressWidth))
        }
        return container
    }
}
