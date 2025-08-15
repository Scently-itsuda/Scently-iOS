//
//  ImageSliderCell.swift
//  Scently
//
//  Created by 임재현 on 8/9/25.
//

import UIKit
import SnapKit

final class ImageSliderCell: UICollectionViewCell,ReuseIdentifying {
    
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        return imageView
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

extension ImageSliderCell {
    
    private func setupUI() {
        self.addSubviews(imageView)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(imageName: String) {
        imageView.image = UIImage(named: imageName)
    }
}
