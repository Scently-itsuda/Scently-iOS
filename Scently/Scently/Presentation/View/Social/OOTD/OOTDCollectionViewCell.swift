//
//  OOTDCollectionViewCell.swift
//  Scently
//
//  Created by dejay on 6/20/25.
//

import UIKit
import SnapKit

final class OOTDCollectionViewCell: UICollectionViewCell, ReuseIdentifying {
    let containerView = UIView()
    
    private let ootdImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        //imageView.image = UIImage(named: "missDior")
        imageView.backgroundColor = .DDDDDD
        imageView.clipsToBounds = true
        return imageView
    }()
    
    private var likeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-nav-like-off"), for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 12)
        button.setTitleColor(.gray3, for: .normal)
        button.tintColor = .gray3
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension OOTDCollectionViewCell {
    func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(ootdImageView)
        containerView.addSubview(likeButton)
    }
    
    func setupConstraint() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        ootdImageView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(ootdImageView.snp.width) // 1:1 정사각형
        }
        
        likeButton.snp.makeConstraints {
            $0.top.trailing.equalTo(containerView)
            $0.width.height.equalTo(40)
        }
    }
}


extension OOTDCollectionViewCell {
    
    func configure(with item: OOTDItem) {
        loadImage(from: item.ootdImageUrl)
        
        let likeImageName = item.isLiked ? "icon-heart-fill" : "icon-nav-like-off"

        likeButton.setImage(UIImage(named: likeImageName), for: .normal)
                
            likeButton.tag = item.ootdId
    }
    
    private func loadImage(from urlString: String) {
        guard let url = URL(string: urlString) else { return }
        
        ootdImageView.image = nil
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                return
            }
            
            DispatchQueue.main.async {
                self?.ootdImageView.image = image
            }
        }.resume()
    }
}
