//
//  AccordView.swift
//  Scently
//
//  Created by 임재현 on 5/30/25.
//

import UIKit
import SnapKit
//
final class AccordView: UIView {

    private let items = [
        "🍊 시트러스", "🌳 우디", "💚 그린",
        "🍑 프루티", "💐 플로럴", "👜 레더",
        "🍒 레드베리", "🧴 파우더리",
        "🔥 엠버", "🌊 아쿠아틱", "🌿 허브",
        "🥥 코코넛", "🕯️ 아로마틱",
        "🌶️ 스파이시", "🍎 애플", "🥛 우유",
        "🪙 메탈릭", "🌬️ 알데하이드",
        "🥜 알몬드", "🌸 라일락", "🌍 얼시",
        "🌹 소피"
    ]
    
    private lazy var collectionView: UICollectionView = {
        let layout = createVariableGroupLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OptionTagCell.self, forCellWithReuseIdentifier: OptionTagCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(10)
            $0.width.equalTo(264)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
        DispatchQueue.main.async {
               print("CollectionView width after constraint123: \(self.collectionView.frame.width)")
           }
    }
}

extension AccordView: UICollectionViewDataSource {
    func collectionView(
        _ collectionView: UICollectionView,
        numberOfItemsInSection section: Int
    ) -> Int {
           return items.count
       }

    func collectionView(
        _ collectionView: UICollectionView,
        cellForItemAt indexPath: IndexPath
    ) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(
            withReuseIdentifier: OptionTagCell.reuseIdentifier,
            for: indexPath
        ) as? OptionTagCell else {
            return UICollectionViewCell()
        }
        cell
            .configure(
                with: items[indexPath.item]
            )
           return cell
       }
    }

extension AccordView {
    func createVariableGroupLayout() -> UICollectionViewCompositionalLayout {
        let itemsPerRow = [3, 3, 2, 3, 2, 3, 2, 3, 1]

        let sectionProvider = { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            var groups: [NSCollectionLayoutGroup] = []

            for itemCount in itemsPerRow {
                var items: [NSCollectionLayoutItem] = []

                for _ in 0..<itemCount {
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .estimated(100),
                        heightDimension: .absolute(28)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
                    items.append(item)
                }

                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(32)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: items
                )
                group.interItemSpacing = .fixed(8)
                groups.append(group)
            }

            // 전체 세로 그룹으로 쌓기
            let containerGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(CGFloat(itemsPerRow.count * 40))
            )
            let containerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: containerGroupSize,
                subitems: groups
            )
            containerGroup.interItemSpacing = .fixed(12)

            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 16, leading: 16, bottom: 16, trailing: 16)
            return section
        }

        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
}
