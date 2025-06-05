//
//  Concentration.swift
//  Scently
//
//  Created by 임재현 on 5/10/25.
//

import UIKit
import SnapKit

final class ConcentrationView: UIView {
    let buttontitles = ["퍼퓸","오 드 퍼퓸","오 드 뚜왈렛","오 드 코롱","오 프레쉬"]
    let buttonSubtitles = ["20% ~ 40%","15% ~ 20%","5% ~ 15%","2% ~ 5%","1% ~ 3%"]
    
    private var selectedIndex: Int? = nil
    
    private lazy var buttonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = false
        
        collectionView.register(ConcentrationCollectionViewCell.self, forCellWithReuseIdentifier: ConcentrationCollectionViewCell.reuseIdentifier)
        
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()

        guard let layout = buttonCollectionView.collectionViewLayout as? UICollectionViewFlowLayout else { return }

        let inset: CGFloat = 16
        let horizontalSpacing: CGFloat = 8
        let verticalSpacing: CGFloat = 12
        let columns: CGFloat = 2
        let availableWidth = buttonCollectionView.bounds.width - inset * 2 - horizontalSpacing
        let itemWidth = floor(availableWidth / columns)

        layout.itemSize = CGSize(width: itemWidth, height: 42)
        layout.minimumInteritemSpacing = horizontalSpacing
        layout.minimumLineSpacing = verticalSpacing
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset/2, bottom: inset, right: inset)
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(buttonCollectionView)
        buttonCollectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(29)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview()
        }
    }
}

extension ConcentrationView: UICollectionViewDelegate {}

extension ConcentrationView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttontitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConcentrationCollectionViewCell.reuseIdentifier, for: indexPath) as? ConcentrationCollectionViewCell else {return UICollectionViewCell()}
      
//        let item = buttontitles[indexPath.item]
        let isSelected = selectedIndex == indexPath.item
        
        cell.configure(
            title: buttontitles[indexPath.row],
            subtitle: buttonSubtitles[indexPath.row],
            isSelected: isSelected
        )
        
//        cell.onTap = { [weak self] in
//               guard let self = self else { return }
//               
//            let previousIndex = self.selectedIndex
//            self.selectedIndex = (self.selectedIndex == indexPath.item) ? nil : indexPath.item
//
//            var indexPathsToReload = [IndexPath(item: indexPath.item, section: 0)]
//            if let previous = previousIndex, previous != indexPath.item {
//                indexPathsToReload.append(IndexPath(item: previous, section: 0))
//            }
//            self.buttonCollectionView.reloadItems(at: indexPathsToReload)
//           }
 
        return cell
        
    }
}
