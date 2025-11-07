//
//  OOTDDetailUserProfileView.swift
//  Scently
//
//  Created by 임재현 on 8/9/25.
//

import UIKit
import SnapKit

final class OOTDDetailUserProfileView: UIView {
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.backgroundColor = .lightGray
//        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFill
        imageView.layer.cornerRadius = 20.5
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let nickNameLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.medium, size: 14)
        titleLabel.textColor = .black
        titleLabel.text = "marvel"
        
        return titleLabel
    }()

    let timeLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.regular, size: 12)
        titleLabel.textColor = .gray3
        titleLabel.text = "· 3시간 전"
        
        return titleLabel
    }()
    
    private let moreButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-more"), for: .normal)
        return button
    }()

    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

extension OOTDDetailUserProfileView {
    func setupUI() {
        self.addSubviews(
            profileImageView,
            nickNameLabel,
            timeLabel,
            moreButton
        )
    }
    
    func setupConstraints() {
        profileImageView.snp.makeConstraints {
            $0.size.equalTo(41)
        }
        
        nickNameLabel.snp.makeConstraints {
            $0.leading.equalTo(profileImageView.snp.trailing).offset(8)
            $0.centerY.equalTo(profileImageView)
        }
        
        timeLabel.snp.makeConstraints {
            $0.leading.equalTo(nickNameLabel.snp.trailing).offset(8)
            $0.centerY.equalTo(profileImageView)
        }
        
        moreButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide)
            $0.centerY.equalTo(profileImageView)
        }
    }
    
    func configure(with profile: String) {
        
    }
}

extension OOTDDetailUserProfileView {
    func configureForComment() {
        profileImageView.layer.cornerRadius = 12
        
        profileImageView.snp.remakeConstraints {
            $0.width.height.equalTo(24)
            $0.leading.centerY.equalToSuperview()
        }
    }
    
    func configure(image: String, nickName: String, time: String) {
        loadImage(from: image)
        self.nickNameLabel.text = nickName
        self.timeLabel.text = time
    }
    
    private func loadImage(from urlString: String) {
        guard !urlString.isEmpty,
              let url = URL(string: urlString) else {
            self.profileImageView.image = UIImage(named: "perfume")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                DispatchQueue.main.async {
                    self?.profileImageView.image = UIImage(named: "placeholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.profileImageView.image = image
            }
        }.resume()
    }
}
