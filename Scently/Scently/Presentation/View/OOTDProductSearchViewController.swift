//
//  OOTDProductSearchViewController.swift
//  Scently
//
//  Created by 임재현 on 11/22/25.
//

import UIKit
import SnapKit

//final class OOTDProductSearchViewController: UIViewController {
//    
//    
//    var onCompleteTapped: (([Product]) -> Void)?
//    
//    private var selectedProducts: [Product] = []
//    
//    private var allPerfumes: [Perfume] = PerfumeMockData2.mockPerfumes
//    private var filteredPerfumes: [Perfume] = []
//    private var isSearching: Bool = false
//    
//    private let navigationBar: UIView = {
//        let view = UIView()
//        view.backgroundColor = .white
//        return view
//    }()
//    
//    private lazy var backButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
//        button.tintColor = .black
//        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private let titleLabel: UILabel = {
//        let label = UILabel()
//        label.text = "제품 선택"
//        label.font = .systemFont(ofSize: 18, weight: .semibold)
//        label.textAlignment = .center
//        label.textColor = .black
//        return label
//    }()
//    
//    private lazy var completeButton: UIButton = {
//        let button = UIButton(type: .system)
//        button.setTitle("완료", for: .normal)
//        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
//        button.tintColor = .systemBlue
//        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
//        return button
//    }()
//    
//    private let tempLabel: UILabel = {
//        let label = UILabel()
//        label.text = "게시글에 등록할 제품을 검색해주세요."
//        label.numberOfLines = 0
//        label.textAlignment = .center
//        label.font = .systemFont(ofSize: 14, weight: .regular)
//        label.textColor = .systemGray
//        return label
//    }()
//    
//    
//    let dividerView = DividerView()
//    
//    let customSearchBar = SearchBarView(
//        configuration: .init(
//            placeholder: "제품명 또는 브랜드 검색",
//            showBottomView: false
//        )
//    )
//    
//    private lazy var collectionView: UICollectionView = {
//        let layout = UICollectionViewFlowLayout()
//        layout.scrollDirection = .vertical
//        layout.minimumLineSpacing = 12
//        layout.minimumInteritemSpacing = 12
//        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
//        
//        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
//        cv.backgroundColor = .white
//        cv.delegate = self
//        cv.dataSource = self
//        cv.register(PerfumeCell.self, forCellWithReuseIdentifier: "PerfumeCell")
//        cv.isHidden = true // 초기에는 숨김
//        return cv
//    }()
//    
//    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        view.backgroundColor = .white
//        setupUI()
//        setupConstraints()
//        setupSearchBar()
//    }
//    
//    private func setupUI() {
//        view.addSubviews(navigationBar,dividerView,customSearchBar,tempLabel,collectionView)
//        navigationBar.addSubviews(backButton, titleLabel, completeButton)
//    }
//    
//    private func setupConstraints() {
//        navigationBar.snp.makeConstraints {
//            $0.top.equalTo(view.safeAreaLayoutGuide)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(44)
//        }
//        
//        backButton.snp.makeConstraints {
//            $0.leading.equalToSuperview().offset(16)
//            $0.centerY.equalToSuperview()
//            $0.width.height.equalTo(44)
//        }
//        
//        titleLabel.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
//        
//        completeButton.snp.makeConstraints {
//            $0.trailing.equalToSuperview().offset(-16)
//            $0.centerY.equalToSuperview()
//        }
//        
//        dividerView.snp.makeConstraints {
//            $0.top.equalTo(navigationBar.snp.bottom).offset(22)
//            $0.leading.trailing.equalToSuperview()
//        }
//        
//        customSearchBar.snp.makeConstraints {
//            $0.top.equalTo(dividerView.snp.bottom).offset(8)
//            $0.leading.trailing.equalToSuperview()
//        }
//        
//        tempLabel.snp.makeConstraints {
//            $0.center.equalToSuperview()
//        }
//        
//        collectionView.snp.makeConstraints {
//            $0.top.equalTo(customSearchBar.snp.bottom).offset(8)
//            $0.leading.trailing.bottom.equalToSuperview()
//        }
//    }
//    
//    private func setupSearchBar() {
//        customSearchBar.delegate = self
//    }
//    
//    func configure(with products: [Product]) {
//        self.selectedProducts = products
//        print("ProductSearchVC에 전달된 제품:", products.count)
//    }
//    
//    private func filterPerfumes(with searchText: String) {
//        if searchText.isEmpty {
//            isSearching = false
//            filteredPerfumes = []
//            collectionView.isHidden = true
//            tempLabel.isHidden = false
//        } else {
//            isSearching = true
//            filteredPerfumes = allPerfumes.filter { perfume in
//                perfume.name.lowercased().contains(searchText.lowercased()) ||
//                perfume.brand.lowercased().contains(searchText.lowercased())
//            }
//            collectionView.isHidden = false
//            tempLabel.isHidden = true
//        }
//        collectionView.reloadData()
//    }
//    
//    
//    @objc private func backButtonTapped() {
//        navigationController?.popViewController(animated: true)
//    }
//    
//    @objc private func completeButtonTapped() {
//        onCompleteTapped?(selectedProducts)
//    }
//}
//// MARK: - UICollectionViewDataSource
//extension OOTDProductSearchViewController: UICollectionViewDataSource {
//    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        return filteredPerfumes.count
//    }
//    
//    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
//        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerfumeCell", for: indexPath) as? PerfumeCell else {
//            return UICollectionViewCell()
//        }
//        
//        let perfume = filteredPerfumes[indexPath.item]
//        cell.configure(with: perfume)
//        return cell
//    }
//}
//
//// MARK: - UICollectionViewDelegate
//extension OOTDProductSearchViewController: UICollectionViewDelegate {
//    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let selectedPerfume = filteredPerfumes[indexPath.item]
//        // TODO: 선택된 제품 처리 (다음 단계에서 구현)
//        print("선택된 향수: \(selectedPerfume.name)")
//    }
//}
//
//// MARK: - UICollectionViewDelegateFlowLayout
//extension OOTDProductSearchViewController: UICollectionViewDelegateFlowLayout {
//    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
//        let width = collectionView.bounds.width - 32 // 좌우 패딩
//        return CGSize(width: width, height: 84) // 이미지(60) + 패딩
//    }
//}
//
//extension OOTDProductSearchViewController: SearchBarViewDelegate {
//    func searchBarView(_ searchBarView: SearchBarView, didChangeSearchText text: String) {
//        filterPerfumes(with: text)
//    }
//}

final class OOTDProductSearchViewController: UIViewController {
    
    var onCompleteTapped: (([Product]) -> Void)?
    
    // 선택된 제품 관리
    private var selectedPerfumes: [Perfume] = [] {
        didSet {
            selectedTableView.reloadData()
            updateCompleteButtonState()
            updateSelectedTableViewHeight()
        }
    }
    
    private var selectedProducts: [Product] = []
    
    private var allPerfumes: [Perfume] = PerfumeMockData2.mockPerfumes
    private var filteredPerfumes: [Perfume] = []
    private var isSearching: Bool = false
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제품 선택"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .systemGray4
        button.isEnabled = false
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "게시글에 등록할 제품을 검색해주세요."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    let dividerView = DividerView()
    
    let customSearchBar = SearchBarView(
        configuration: .init(
            placeholder: "제품명 또는 브랜드 검색",
            showBottomView: false
        )
    )
    
    // 선택된 제품 보여주는 TableView 추가
    private lazy var selectedTableView: UITableView = {
        let tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(ProductTableViewCell.self, forCellReuseIdentifier: ProductTableViewCell.reuseIdentifier)
        tableView.separatorStyle = .none
        tableView.backgroundColor = .white
        tableView.isHidden = true
        tableView.isScrollEnabled = false
        return tableView
    }()
    
    private lazy var collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumLineSpacing = 12
        layout.minimumInteritemSpacing = 12
        layout.sectionInset = UIEdgeInsets(top: 16, left: 16, bottom: 16, right: 16)
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.register(PerfumeCell.self, forCellWithReuseIdentifier: "PerfumeCell")
        cv.isHidden = true
        return cv
    }()
    
    private let noticeView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.systemRed.withAlphaComponent(0.9)
        view.layer.cornerRadius = 8
        view.isHidden = true
        view.alpha = 0
        return view
    }()

    private let noticeIconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(systemName: "exclamationmark.triangle.fill")
        imageView.tintColor = .white
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()

    private let noticeLabel: UILabel = {
        let label = UILabel()
        label.text = "제품은 최대 3개까지 등록할 수 있습니다"
        label.font = .systemFont(ofSize: 14, weight: .medium)
        label.textColor = .white
        label.textAlignment = .left
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupSearchBar()
    }
    
    private func setupUI() {
        view.addSubviews(navigationBar, dividerView, selectedTableView, customSearchBar, tempLabel, collectionView,noticeView)
        navigationBar.addSubviews(backButton, titleLabel, completeButton)
        noticeView.addSubviews(noticeIconImageView, noticeLabel)
    }
    
    private func setupConstraints() {
        
        noticeView.snp.makeConstraints {
               $0.leading.trailing.equalToSuperview().inset(16)
               $0.bottom.equalTo(selectedTableView.snp.top).offset(-8)
               $0.height.equalTo(52)
           }
           
           noticeIconImageView.snp.makeConstraints {
               $0.leading.equalToSuperview().offset(16)
               $0.centerY.equalToSuperview()
               $0.width.height.equalTo(20)
           }
           
           noticeLabel.snp.makeConstraints {
               $0.leading.equalTo(noticeIconImageView.snp.trailing).offset(12)
               $0.trailing.equalToSuperview().offset(-16)
               $0.centerY.equalToSuperview()
           }
        
        
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
        
        customSearchBar.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        collectionView.snp.makeConstraints {
            $0.top.equalTo(customSearchBar.snp.bottom).offset(8)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        // 선택된 제품 TableView - 하단에 배치
        selectedTableView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
            $0.height.equalTo(0)
        }
    }
    
    
    
    private func setupSearchBar() {
        customSearchBar.delegate = self
    }
    
    func configure(with products: [Product]) {
        self.selectedProducts = products
        print("ProductSearchVC에 전달된 제품:", products.count)
    }
    
    private func filterPerfumes(with searchText: String) {
        if searchText.isEmpty {
            isSearching = false
            filteredPerfumes = []
            collectionView.isHidden = true
            // tempLabel은 selectedPerfumes가 비어있을 때만 보이게
            tempLabel.isHidden = !selectedPerfumes.isEmpty
        } else {
            isSearching = true
            // 이미 선택된 제품 제외
            filteredPerfumes = allPerfumes.filter { perfume in
                let isNotSelected = !selectedPerfumes.contains(where: { $0.perfumeId == perfume.perfumeId })
                let matchesSearch = perfume.name.lowercased().contains(searchText.lowercased()) ||
                                  perfume.brand.lowercased().contains(searchText.lowercased())
                return isNotSelected && matchesSearch
            }
            collectionView.isHidden = false
            tempLabel.isHidden = true
        }
        collectionView.reloadData()
    }
    
    // 제품 선택
    private func selectPerfume(_ perfume: Perfume) {
        guard selectedPerfumes.count < 3 else {
            showMaxSelectionNotice()
            return
        }
        selectedPerfumes.append(perfume)
        
        // 검색창 초기화 및 검색 결과 숨기기
        customSearchBar.clearSearchText()
        
        // 검색 상태 초기화
        isSearching = false
        filteredPerfumes = []
        collectionView.isHidden = true
        tempLabel.isHidden = false
    }
    
//    private func showMaxSelectionNotice() {
//        // 이미 표시 중이면 무시
//        guard noticeView.isHidden else { return }
//        
//        // 검색창 초기화 및 검색 결과 숨기기
//        customSearchBar.clearSearchText()
//        
//        // 검색 상태 초기화
//        isSearching = false
//        filteredPerfumes = []
//        collectionView.isHidden = true
//        tempLabel.isHidden = false
//        
//        noticeView.isHidden = false
//        
//        // 페이드 인 애니메이션
//        UIView.animate(withDuration: 0.3) {
//            self.noticeView.alpha = 1.0
//        } completion: { _ in
//            // 3초 후 페이드 아웃
//            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
//                UIView.animate(withDuration: 0.3) {
//                    self.noticeView.alpha = 0
//                } completion: { _ in
//                    self.noticeView.isHidden = true
//                }
//            }
//        }
//    }
    
    private func showMaxSelectionNotice() {
        // 이미 표시 중이면 무시
        guard noticeView.isHidden else { return }
        
        // 검색창 초기화 및 검색 결과 숨기기
        customSearchBar.clearSearchText()
        
        // 검색 상태 초기화
        isSearching = false
        filteredPerfumes = []
        collectionView.isHidden = true
        tempLabel.isHidden = false
        
        noticeView.isHidden = false
        noticeView.alpha = 0 // 시작은 투명하게
        tempLabel.isHidden = true
        
        // 페이드 인 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.noticeView.alpha = 1.0
        } completion: { _ in
            // 3초 후 페이드 아웃
            DispatchQueue.main.asyncAfter(deadline: .now() + 3.0) {
                UIView.animate(withDuration: 0.3, animations: {
                    self.noticeView.alpha = 0
                }, completion: { _ in
                    self.noticeView.isHidden = true
                    self.noticeView.alpha = 1.0 // 다음을 위해 alpha 복원
                })
            }
        }
    }
    
    // 제품 선택 해제
    private func deselectPerfume(at index: Int) {
        selectedPerfumes.remove(at: index)
    }
    
    // TableView 높이 업데이트
    private func updateSelectedTableViewHeight() {
        let cellHeight: CGFloat = 72
        let newHeight = CGFloat(selectedPerfumes.count) * cellHeight
        
        selectedTableView.snp.updateConstraints {
            $0.height.equalTo(newHeight)
        }
        
        selectedTableView.isHidden = selectedPerfumes.isEmpty
        
        // 선택된 제품이 있으면 tempLabel 숨기기, 없으면 보이기 (검색 중이 아닐 때만)
        if selectedPerfumes.isEmpty {
            tempLabel.isHidden = isSearching
        } else {
            tempLabel.isHidden = true
        }
        
        UIView.animate(withDuration: 0.3) {
            self.view.layoutIfNeeded()
        }
    }
    
    // 완료 버튼 상태 업데이트
    private func updateCompleteButtonState() {
        let hasSelection = !selectedPerfumes.isEmpty
        completeButton.isEnabled = hasSelection
        completeButton.tintColor = hasSelection ? .systemBlue : .systemGray4
    }
    
    // 최대 선택 알림
    private func showMaxSelectionAlert() {
        let alert = UIAlertController(
            title: "선택 제한",
            message: "최대 3개까지만 선택 가능합니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeButtonTapped() {
        // Perfume을 Product로 변환
        let products = selectedPerfumes.map { perfume in
            Product(
                id: String(perfume.perfumeId),
                name: perfume.name,
                brand: perfume.brand,
                imageURL: perfume.imageURL
            )
        }
        onCompleteTapped?(products)
    }
}

// MARK: - SearchBarViewDelegate
extension OOTDProductSearchViewController: SearchBarViewDelegate {
    func searchBarView(_ searchBarView: SearchBarView, didChangeSearchText text: String) {
        filterPerfumes(with: text)
    }
}

// MARK: - UICollectionViewDataSource (검색 결과)
extension OOTDProductSearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredPerfumes.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PerfumeCell", for: indexPath) as? PerfumeCell else {
            return UICollectionViewCell()
        }
        
        let perfume = filteredPerfumes[indexPath.item]
        cell.configure(with: perfume)
        return cell
    }
}

// MARK: - UICollectionViewDelegate
extension OOTDProductSearchViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedPerfume = filteredPerfumes[indexPath.item]
        selectPerfume(selectedPerfume)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension OOTDProductSearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = collectionView.bounds.width - 32
        return CGSize(width: width, height: 84)
    }
}

// MARK: - UITableViewDataSource (선택된 제품)
extension OOTDProductSearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return selectedPerfumes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: ProductTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? ProductTableViewCell else {
            return UITableViewCell()
        }
        
        let perfume = selectedPerfumes[indexPath.row]
        cell.configure(with: perfume, mode: .selection)
        return cell
    }
}

// MARK: - UITableViewDelegate
extension OOTDProductSearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 72
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        deselectPerfume(at: indexPath.row)
    }
}
