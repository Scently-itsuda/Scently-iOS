//
//  NationView.swift
//  Scently
//
//  Created by 임재현 on 5/25/25.
//

import UIKit
import SnapKit
import Combine

final class NationView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    @Published private var selectedIndices: Set<Int> = []
    
    private let items = [
        "대한민국", "프랑스", "영국",
        "미국", "스웨덴", "이탈리아",
        "독일", "일본"
    ]
    
    
    private lazy var collectionView: UICollectionView = {
        let layout = createVariableGroupLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(OptionTagCell.self, forCellWithReuseIdentifier: OptionTagCell.reuseIdentifier)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        return collectionView
    }()

    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(collectionView)
        collectionView.backgroundColor = .white
        collectionView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.width.equalTo(264)
            $0.leading.equalToSuperview()
            $0.bottom.equalToSuperview()
        }
    }
    
    private func setBinding() {
        $selectedIndices
            .sink { [weak self] _ in
                self?.collectionView.reloadData()
            }
            .store(in: &cancellables)
    }
    
    private func handelCellTap(at index: Int) {
        if selectedIndices.contains(index) {
            selectedIndices.remove(index)
        } else {
            selectedIndices.insert(index)
        }
    }

}





extension NationView: UICollectionViewDataSource,UICollectionViewDelegate {
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
        
        let isSelected = selectedIndices.contains(indexPath.item)
        cell
            .configure(
                with: items[indexPath.item], isSelected: isSelected
            )
           return cell
       }
    
    func collectionView(
        _ collectionView: UICollectionView,
        didSelectItemAt indexPath: IndexPath
    ) {
        handelCellTap(
            at: indexPath.item
        )
    }
}

extension NationView {
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
