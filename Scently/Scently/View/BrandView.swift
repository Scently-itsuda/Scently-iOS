//
//  BrandView.swift
//  Scently
//
//  Created by 임재현 on 5/24/25.
//

import UIKit
import SnapKit

final class BrandView: UIView {
    let buttonTitles = ["샤넬","조말론","딥디크","디올","톰포드","바이레도","불가리","크리드","포맨트","랑방","구찌","버버리","르라보","끌로에","몽블랑","클린","러쉬","베르사체","지미추","겐조","아쿠 아디파르마","마크제이콥스","존바바토스","페라리","캘빈클라인","페라가모","조르지오아르마니"]
    
    let subTitles = [
        "CHANEL","JO MALONE","DIPTYQUE","DIOR","TOMFORD","BYREDO","BULGARI","CREED","FORMENT","LANVIN",
        "GUCCI","BURBERRY","LE LABO","CHLOE","MONTBLANC","CLEAN","LASH","VERSACE","JIMMY CHOO","KENZO",
        "ACQUA DI PARMA","MARC JACOBS","JOHN VARVATOS","FERRARI","CALVIN KLEIN","FERRAGAMO",
        "GIORGIO ARMANI"
    ]
    
    private lazy var buttonCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.isScrollEnabled = true
        
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
        super.init(frame: .zero)
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

extension BrandView: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return buttonTitles.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: ConcentrationCollectionViewCell.reuseIdentifier, for: indexPath) as? ConcentrationCollectionViewCell else {return UICollectionViewCell()}
       
        cell.configure(title: buttonTitles[indexPath.row],
                       subtitle: subTitles[indexPath.row],
                       isSelected: false)
        
        return cell
    }
}
