//
//  SocialViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class SocialViewController: UIViewController {
    let socialView = SocialView()
    let pageViewController = SocialTabbarPageViewController()  // 초기화 될때 scroll 스타일 적용
    
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
        
        // 1. 뷰컨트롤러들을 생성하고 배열에 저장
        tabbarViewModel.setupViewControllers()

        // 2. 생성된 배열에서 초기 페이지 설정
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
    }
    
    func setupConstraint() {
        pageViewController.view.snp.makeConstraints {
            $0.top.equalTo(socialView.customSearchBar.snp.bottom).offset(12)
            $0.leading.trailing.bottom.equalToSuperview()
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
