//
//  ImageSliderView.swift
//  Scently
//
//  Created by 임재현 on 8/9/25.
//

import UIKit
import SnapKit

final class ImageSliderView: UIView {
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = .clear
        
        return collectionView
    }()
    
    private let pageIndicatorLabel: UILabel = {
       let label = UILabel()
        label.font = .pretendard(.medium, size: 12)
        label.textColor = .white
        label.backgroundColor = .black
        label.textAlignment = .center
        label.layer.cornerRadius = 12
        label.clipsToBounds = true
        
        return label
    }()
    
    private var images: [String] = [
        "missDior",
        "perfume",
        "dior 향수"
    ]
    
    private var currentPage = 0 {
        didSet {
            updatePageIndicator()
        }
    }
    
    private var needsInitialSetup = true
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        if needsInitialSetup && !images.isEmpty {
            updatePageIndicator()
            needsInitialSetup = false
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupCollectionView()
       
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ImageSliderView {
    private func setupUI() {
        self.addSubviews(collectionView,pageIndicatorLabel)
    }
    
    private func setupConstraints() {
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        pageIndicatorLabel.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(24)
            $0.width.greaterThanOrEqualTo(40)
        }
    }
    
    func configure(images: [String]) {
        self.images = images
        self.currentPage = 0
        collectionView.reloadData()
    }
    
    func setupCollectionView() {
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(ImageSliderCell.self, forCellWithReuseIdentifier: ImageSliderCell.reuseIdentifier)
    }
    
    private func updatePageIndicator() {
        pageIndicatorLabel.text = "\(currentPage + 1) / \(images.count)"
    }
}

extension ImageSliderView: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return images.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ImageSliderCell.reuseIdentifier, for: indexPath) as? ImageSliderCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(imageName: images[indexPath.item])
        return cell

    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
       return  collectionView.bounds.size
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.bounds.width
        currentPage = Int(scrollView.contentOffset.x / pageWidth)
    }
    
}
