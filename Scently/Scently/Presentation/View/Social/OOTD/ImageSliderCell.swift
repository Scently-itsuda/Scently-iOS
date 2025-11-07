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
        loadImage(from: imageName)
    }
    
    private func loadImage(from urlString: String) {
        guard !urlString.isEmpty,
              let url = URL(string: urlString) else {
            self.imageView.image = UIImage(named: "perfume")
            return
        }
        
        URLSession.shared.dataTask(with: url) { [weak self] data, response, error in
            guard let data = data,
                  let image = UIImage(data: data),
                  error == nil else {
                DispatchQueue.main.async {
                    self?.imageView.image = UIImage(named: "placeholder")
                }
                return
            }
            
            DispatchQueue.main.async {
                self?.imageView.image = image
            }
        }.resume()
    }
    
}
