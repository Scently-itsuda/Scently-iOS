//
//  RecentProductsView.swift
//  Scently
//
//  Created by 임재현 on 8/16/25.
//

import UIKit
import SnapKit

final class RecentProductsView: UIView {
    
    private let headerView: UIView = {
        let view = UIView()
        
        return view
    }()
    
    private let recentLabel: UILabel = {
        let label = UILabel()
        label.text = "최근 본 제품 "
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        
        return label
        
    }()
    
    private let rightArrowView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "icon-enter")
        imageView.tintColor = .black
        
        return imageView
    }()
    
    private lazy var perfumeCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let inset: CGFloat = 16
        let spacing: CGFloat = 12
        let availableWidth = UIScreen.main.bounds.width - (inset * 2)
        let estimatedItemWidth: CGFloat = 100  // 최소 보장할 셀 너비
        let itemsInRow = floor((availableWidth + spacing) / (estimatedItemWidth + spacing))
        let totalSpacing = spacing * (itemsInRow - 1)
        let itemWidth = (availableWidth - totalSpacing) / itemsInRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: PerfumeCollectionViewCell.reuseIdentifier)
        collectionView.isScrollEnabled = false
        return collectionView
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

extension RecentProductsView {
    private func setupUI() {
        self.addSubviews(headerView,perfumeCollectionView)
        self.headerView.addSubviews(recentLabel,rightArrowView)
    }
    
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        recentLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
        }
        
        rightArrowView.snp.makeConstraints {
            $0.centerY.equalTo(recentLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(16)
            $0.size.equalTo(24)
        }
        
        perfumeCollectionView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(160) 
            $0.bottom.equalToSuperview()
        }
    }
}

extension RecentProductsView: UICollectionViewDelegate,UICollectionViewDataSource {

    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 3
    }
    
    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: PerfumeCollectionViewCell.reuseIdentifier,
            for: indexPath
        ) as? PerfumeCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        cell.configure(
            title: "제품 \(indexPath.item + 1)",
            subTitle: "브랜드 \(indexPath.item + 1)",
            imageURL: "https://picsum.photos/200/300?random=\(indexPath.item + 1)"
        )
        
//        cell.configure(
//            title: "제품 \(indexPath.item + 1)",
//            subTitle: "브랜드 \(indexPath.item + 1)",
//            imageURL: "https://scently-pefume-s3.s3.ap-northeast-2.amazonaws.com/perfumes/byredo_mumbai_noise.jpg"
//        )
        
        return cell
    }
}
