//
//  RecentlyViewedViewController.swift
//  Scently
//
//  Created by 임재현 on 8/24/25.
//

import UIKit
import SnapKit

final class RecentlyViewedViewController: UIViewController {
    
    private var profileEditNavigationView = ProfileEditNavigationView()
    
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
        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        profileEditNavigationView.configure(title: "최근 본 제품")
        profileEditNavigationView.delegate = self
    }
}

extension RecentlyViewedViewController {
    private func setupUI() {
        self.view.addSubviews(perfumeCollectionView,profileEditNavigationView)
    }
    private func setupConstraints() {
        
        profileEditNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        perfumeCollectionView.snp.makeConstraints {
            $0.top.equalTo(profileEditNavigationView.snp.bottom).offset(4)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
}

extension RecentlyViewedViewController: UICollectionViewDelegate  {
    
}

extension RecentlyViewedViewController: UICollectionViewDataSource {
    
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: PerfumeCollectionViewCell.reuseIdentifier, for: indexPath) as? PerfumeCollectionViewCell else {return UICollectionViewCell()}
//        let perfume = perfumes[indexPath.row]
//        cell.configure(title: perfume.name, subTitle: perfume.brand,imageURL: perfume.imageURL)
        cell.backgroundColor = .white
        return cell
    }
}

extension RecentlyViewedViewController: ProfileEditNavigationViewDelegate {
    func profileEditButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
