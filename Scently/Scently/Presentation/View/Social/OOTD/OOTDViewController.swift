//
//  OOTDViewController.swift
//  Scently
//
//  Created by dejay on 6/20/25.
//

import UIKit
import SnapKit
import Combine

final class OOTDViewController: UIViewController {
    
    private var coordinator: SocialCoordinatorProtocol?
    private let viewModel = OOTDViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private var ootdItems: [OOTDItem] = []
    
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
        setBinding()
        //viewModel.getOOTDList(order: "NEWEST_DESCENDING", page: 1, size: 1)
        
        viewModel.loadMockData()
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
    
    func setBinding() {
        viewModel.ootdList
            .receive(on: DispatchQueue.main)
            .sink { [weak self] data in
                self?.updateUI(with: data)
            }
            .store(in: &cancellables)
        
        viewModel.isLoading
             .receive(on: DispatchQueue.main)
             .sink { [weak self] isLoading in
                 self?.updateLoadingState(isLoading)
             }
             .store(in: &cancellables)
        
        viewModel.errorMessage
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] errorMessage in
                self?.showError(errorMessage)
            }
            .store(in: &cancellables)

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
        ootdItems.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: OOTDCollectionViewCell.reuseIdentifier, for: indexPath) as? OOTDCollectionViewCell else {
            return UICollectionViewCell()
        }
        
        let item = ootdItems[indexPath.item]
        cell.configure(with: item)
        
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
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("didSelectItemAt cell \(indexPath.row)")        
        coordinator?.showOOTDDetail(ootdId: indexPath.row)
    }
}

extension OOTDViewController {
    
    private func updateUI(with data: OOTDListData?) {
        guard let data = data else { return }
        
        self.ootdItems = data.dataList
        self.ootdCollectionView.reloadData()
        print("OOTD 아이템 \(data.dataList.count)개 로드됨")
        print("현재 페이지: \(data.pageInfo.page)/\(data.pageInfo.totalPages)")
    }
    
    private func updateLoadingState(_ isLoading: Bool) {
        if isLoading {
            //TODO: - 로딩 인디케이터 표시(로딩화면)

        } else {
            //TODO: - 로딩 인디케이터 숨김(로딩완료시)
        }
    }
    
    private func showError(_ message: String) {
        let alert = UIAlertController(title: "오류", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}
