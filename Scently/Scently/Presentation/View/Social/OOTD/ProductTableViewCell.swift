//
//  ProductTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class ProductTableViewCell: UITableViewCell, ReuseIdentifying {
    
    enum CellMode {
        case like      // 좋아요 버튼 (하트)
        case selection // 선택 모드 (X 버튼)
    }
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let perfumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "perfume")
        imageView.contentMode = .scaleAspectFit
        imageView.layer.masksToBounds = true
        imageView.layer.cornerRadius = 6
        return imageView
    }()
    
    private var brandLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.light, size: 10)
        label.textColor = .gray3
        label.text = "DIOR"
        return label
    }()
    
    private var perfumeTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.medium, size: 16)
        label.textColor = .black
        label.text = "미스 디올 오 드 퍼퓸"
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-like-#12"), for: .normal)
        return button
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // Configure 메서드 - 기본값은 .like 모드
    func configure(with perfume: Perfume, mode: CellMode = .like) {
        brandLabel.text = perfume.brand
        perfumeTitleLabel.text = perfume.name
        
        // 기존 constraints 제거
        actionButton.snp.removeConstraints()
        
        // 모드에 따라 버튼 아이콘과 크기 변경
        switch mode {
        case .like:
            actionButton.setImage(UIImage(named: "icon-like-#12"), for: .normal)
            actionButton.tintColor = nil
            actionButton.snp.makeConstraints {
                $0.size.equalTo(24)
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
            }
            
        case .selection:
            actionButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
            actionButton.tintColor = .systemGray3
            actionButton.snp.makeConstraints {
                $0.size.equalTo(20) // X 버튼은 조금 작게
                $0.centerY.equalToSuperview()
                $0.trailing.equalToSuperview().inset(20)
            }
        }
        
        // 이미지 로딩
        // perfumeImageView.kf.setImage(with: URL(string: perfume.imageURL))
    }
}

extension ProductTableViewCell {
    private func setupUI() {
        self.addSubviews(containerView)
        
        containerView
            .addSubviews(
                perfumeImageView,
                brandLabel,
                perfumeTitleLabel,
                actionButton
            )
        
        containerView.layer.borderWidth = 1
        containerView.layer.borderColor = UIColor.lightgray.cgColor
        containerView.layer.cornerRadius = 6

        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(6)
        }
        
        perfumeImageView.snp.makeConstraints {
            $0.top.leading.bottom.equalToSuperview()
            $0.width.equalTo(60)
        }
        
        brandLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.leading.equalTo(perfumeImageView.snp.trailing).offset(16)
        }
        
        perfumeTitleLabel.snp.makeConstraints {
            $0.leading.equalTo(brandLabel.snp.leading)
            $0.top.equalTo(brandLabel.snp.bottom).offset(4)
        }
        
        // actionButton의 초기 constraints (like 모드 기본값)
        actionButton.snp.makeConstraints {
            $0.size.equalTo(24)
            $0.centerY.equalToSuperview()
            $0.trailing.equalToSuperview().inset(20)
        }
    }
}
