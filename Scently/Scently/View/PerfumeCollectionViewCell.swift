//
//  PerfumeCollectionViewCell.swift
//  Scently
//
//  Created by 임재현 on 5/4/25.
//

import UIKit
import SnapKit

class PerfumeCollectionViewCell: UICollectionViewCell {
   
    private let perfumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "dior 향수")
        imageView.backgroundColor = .white
        imageView.clipsToBounds = true
        imageView.layer.cornerRadius = 12
        return imageView
    }()
    
    private let shadowContainerView: UIView = {
        let view = UIView()
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.2
        view.layer.shadowOffset = CGSize(width: 0, height: 1)
        view.layer.shadowRadius = 6
        view.layer.cornerRadius = 12
        view.backgroundColor = .clear
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Dior"
        label.textColor = .black
        label.font = .pretendard(.bold, size: 11)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "크리스찬 디올"
        label.textColor = .black
        label.font = .pretendard(.regular, size: 11)
        label.numberOfLines = 1
        label.lineBreakMode = .byTruncatingTail
        return label
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
        self.backgroundColor = .white
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private func setupLayout() {
        [shadowContainerView,titleLabel,subTitleLabel].forEach {
            self.addSubview($0)
        }
        
        shadowContainerView.addSubview(perfumeImageView)

        shadowContainerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalToSuperview().multipliedBy(0.75)
        }
        
        perfumeImageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeImageView.snp.bottom).offset(8)
            $0.centerX.equalToSuperview()
        }
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
    
    }
}
