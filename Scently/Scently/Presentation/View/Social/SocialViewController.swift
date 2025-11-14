//
//  SocialViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class SocialViewController: UIViewController {
    
    weak var coordinator: SocialCoordinatorProtocol?
    var isGuestMode: Bool = false
    
    let socialView = SocialView()
    let pageViewController = SocialTabbarPageViewController()  // 초기화 될때 scroll 스타일 적용
    
    private var actionItemViews: [FloatingActionItemView] = []
    private let floatingMainButton = UIButton(type: .custom)
    private var isExpanded = false
    
    private let dimmedBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.alpha = 0
        view.isUserInteractionEnabled = true
        return view
    }()
    
    var tabbarViewModel = TabBarViewModel()
    
    var currentPage: Int = 0 {
        didSet {
            bind(oldValue: oldValue, newValue: currentPage)
        }
    }
    
    override func loadView() {
        super.loadView()
        self.view = socialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setupCollectionViewDelegate()
        registerCell()
        setupFloatingButtons()
        
        // dataSourceVC가 비어있지 않으면 사용 (Coordinator가 주입한 것)
        // 비어있으면 fallback으로 생성
        if tabbarViewModel.dataSourceVC.isEmpty {
            tabbarViewModel.setupViewControllers()
        }
        
        // PageViewController 초기 설정
        if let firstVC = tabbarViewModel.dataSourceVC.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        pageViewController.didMove(toParent: self)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        currentPage = 0
    }
    
    func didTapCell(at indexPath: IndexPath) {
        currentPage = indexPath.item
    }
}

private extension SocialViewController {
    func setupUI() {
        self.view.backgroundColor = .white
        addChild(pageViewController)
        view.addSubview(pageViewController.view)
        view.addSubview(dimmedBackgroundView)
    }
    
    func setupConstraint() {
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(socialView.customSearchBar.snp.bottom).offset(13)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        dimmedBackgroundView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupCollectionViewDelegate() {
        socialView.tabbarView.collectionView.dataSource = self
        socialView.tabbarView.collectionView.delegate = self
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        pageViewController.didMove(toParent: self)
    }
    
    func registerCell() {
        socialView.tabbarView.collectionView.register(TabBarCollectionViewCell.self, forCellWithReuseIdentifier: TabBarCollectionViewCell.reuseIdentifier)
    }
    
    func setupFloatingButtons() {
        // 메인 + 버튼
        floatingMainButton.backgroundColor = .black
        floatingMainButton.setImage(UIImage(systemName: "plus"), for: .normal)
        floatingMainButton.tintColor = .white
        floatingMainButton.layer.cornerRadius = 20
        floatingMainButton.addTarget(self, action: #selector(toggleFloatingButtons), for: .touchUpInside)
        view.addSubview(floatingMainButton)
        
        floatingMainButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().inset(24)
            $0.bottom.equalToSuperview().inset(96)
            $0.width.height.equalTo(40)
        }
        
        let items: [(String, String)] = [
            ("리뷰쓰기", "person.crop.circle"),
            ("자유게시판 글쓰기", "pencil.and.outline"),
            ("OOTD 글쓰기", "square.and.pencil")
        ]
        
        for (index, item) in items.enumerated() {
            let itemView = FloatingActionItemView(title: item.0, iconName: item.1)
            itemView.alpha = 0
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(floatingItemTapped(_:)))
            itemView.tag = index
            itemView.addGestureRecognizer(tapGesture)
            itemView.isUserInteractionEnabled = true
            view.addSubview(itemView)
            
            itemView.snp.makeConstraints {
                $0.trailing.equalTo(floatingMainButton.snp.trailing)
                $0.centerY.equalTo(floatingMainButton.snp.centerY)
            }
            
            actionItemViews.append(itemView)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(toggleFloatingButtons))
                dimmedBackgroundView.addGestureRecognizer(tapGesture)
    }

    @objc func toggleFloatingButtons() {
        isExpanded.toggle()

        let iconName = isExpanded ? "xmark" : "plus"
        floatingMainButton.setImage(UIImage(systemName: iconName), for: .normal)

        // Dimmed background 애니메이션
        UIView.animate(withDuration: 0.3) {
            self.dimmedBackgroundView.alpha = self.isExpanded ? 1 : 0
        }
        
        // dimmedBackgroundView를 floating button 바로 아래로 이동
        if isExpanded {
            view.bringSubviewToFront(dimmedBackgroundView)
            view.bringSubviewToFront(floatingMainButton)
            actionItemViews.forEach { view.bringSubviewToFront($0) }
        }

        for (index, itemView) in actionItemViews.enumerated() {
            UIView.animate(withDuration: 0.3, delay: 0.05 * Double(index), options: [], animations: {
                if self.isExpanded {
                    itemView.alpha = 1
                    itemView.transform = CGAffineTransform(translationX: 0, y: CGFloat(-60 * (index + 1)))
                } else {
                    itemView.alpha = 0
                    itemView.transform = .identity
                }
            }, completion: nil)
        }
    }
    
    @objc private func floatingItemTapped(_ sender: UITapGestureRecognizer) {
        
        guard let index = sender.view?.tag else { return }
       
        // FloatingButton 닫기
        toggleFloatingButtons()
        
        // Coordinator로 화면 전환
        switch index {
        case 0:  // 리뷰쓰기
            coordinator?.showReviewWrite()
        case 1:  // 자유게시판 글쓰기
            coordinator?.showFreeBoardWrite()
        case 2:  // OOTD 글쓰기
            coordinator?.showOOTDWrite()
        default:
            break
        }
    }
    
    func bind(oldValue: Int, newValue: Int) {
        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([tabbarViewModel.dataSourceVC[currentPage]], direction: direction, animated: true, completion: nil)
        
        // pageViewController에서 paging한 경우
        socialView.tabbarView.collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension SocialViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabbarViewModel.socialTabbarList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.reuseIdentifier, for: indexPath) as? TabBarCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.titleLabel.text = tabbarViewModel.socialTabbarList[indexPath.item]

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = socialView.tabbarView.collectionView.frame.width
        let menuWidth = (width / 2) / 3
        
        let height = socialView.tabbarView.collectionView.frame.height
        
        return CGSize(width: menuWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TabbarCell Tapped")
        self.didTapCell(at: indexPath)
    }
}

// MARK: - UIPageViewControllerDelegate, UIPageViewControllerDataSource

extension SocialViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = tabbarViewModel.dataSourceVC.firstIndex(of: viewController) else {
            return nil
        }
        
        let previousIndex = index - 1
        
        if previousIndex < 0 {
            return nil
        }
        
        return tabbarViewModel.dataSourceVC[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = tabbarViewModel.dataSourceVC.firstIndex(of: viewController) else {
            return nil
        }
        
        let nextIndex = index + 1
        
        if nextIndex == tabbarViewModel.dataSourceVC.count {
            return nil
        }
        
        return tabbarViewModel.dataSourceVC[nextIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let currentVC = pageViewController.viewControllers?.first,
              let currentIndex = tabbarViewModel.dataSourceVC.firstIndex(of: currentVC) else {
            return
        }
        
        currentPage = currentIndex
    }
}
