//
//  OOTDViewController.swift
//  Scently
//
//  Created by dejay on 6/20/25.
//

import UIKit
import SnapKit

final class OOTDViewController: UIViewController {
    lazy var ootdCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 8
        layout.minimumInteritemSpacing = 8
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.showsVerticalScrollIndicator = false

        return collectionView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setupCollectionView()
    }
}

extension OOTDViewController {
    func setupUI() {
        self.view.addSubview(ootdCollectionView)
    }
    
    func setupConstraint() {
        ootdCollectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupCollectionView() {
        ootdCollectionView.delegate = self
        ootdCollectionView.dataSource = self
        
        ootdCollectionView.register(OOTDCollectionViewCell.self, forCellWithReuseIdentifier: OOTDCollectionViewCell.reuseIdentifier)
    }
}

extension OOTDViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        10
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OOTDCollectionViewCell.reuseIdentifier, for: indexPath) as? OOTDCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let spacing: CGFloat = 1
        let numberOfItemsPerRow: CGFloat = 2
        
        let totalSpacing = spacing * (numberOfItemsPerRow + 1)
        let itemWidth = (collectionView.bounds.width - totalSpacing) / numberOfItemsPerRow
        print("itemWidth \(itemWidth)")
        
        return CGSize(width: itemWidth, height: itemWidth)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        // 셀 사이의 간격
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        // 위 아래 간격
        return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        // 좌우 여백 없이
        return .zero
    }
}
