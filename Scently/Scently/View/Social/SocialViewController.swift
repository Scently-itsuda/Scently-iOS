//
//  SocialViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

// MARK: - FloatingActionItemDelegate 추가
protocol FloatingActionItemDelegate: AnyObject {
    func didTapFloatingActionItem(with title: String)
}

final class SocialViewController: UIViewController {
    let socialView = SocialView()
    let pageViewController = SocialTabbarPageViewController()  // 초기화 될때 scroll 스타일 적용
    
    private var actionItemViews: [FloatingActionItemView] = []
    private let floatingMainButton = UIButton(type: .custom)
    private var isExpanded = false
    
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
        
        // 1. 뷰컨트롤러들을 생성하고 배열에 저장
        tabbarViewModel.setupViewControllers()

        // 2. 생성된 배열에서 초기 페이지 설정
        if let firstVC = tabbarViewModel.dataSourceVC.first {
            pageViewController.setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        pageViewController.didMove(toParent: self)
        
        // NotificationCenter 옵저버 추가
//        NotificationCenter.default.addObserver(
//            self,
//            selector: #selector(handleFloatingButtonTapped(_:)),
//            name: NSNotification.Name("FloatingButtonTapped"),
//            object: nil
//        )
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
            $0.top.equalTo(socialView.customSearchBar.snp.bottom).offset(13)
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
            
            // 초기에는 보이지 않음 (정상 동작)
            itemView.alpha = 0
            
            itemView.delegate = self
            view.addSubview(itemView)
            
            itemView.snp.makeConstraints {
                $0.trailing.equalTo(floatingMainButton.snp.trailing)
                $0.centerY.equalTo(floatingMainButton.snp.centerY)
            }
            
            actionItemViews.append(itemView)
        }
    }

    @objc func toggleFloatingButtons() {
        isExpanded.toggle()

        let iconName = isExpanded ? "xmark" : "plus"
        floatingMainButton.setImage(UIImage(systemName: iconName), for: .normal)

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
    
    func bind(oldValue: Int, newValue: Int) {
        // collectionView 에서 선택한 경우
        let direction: UIPageViewController.NavigationDirection = oldValue < newValue ? .forward : .reverse
        pageViewController.setViewControllers([tabbarViewModel.dataSourceVC[currentPage]], direction: direction, animated: true, completion: nil)
        
        // pageViewController에서 paging한 경우
        socialView.tabbarView.collectionView.selectItem(at: IndexPath(item: currentPage, section: 0), animated: true, scrollPosition: .centeredHorizontally)
    }
    
    // MARK: - Navigation Methods
    private func navigateToOOTDViewController() {
        // 먼저 플로팅 버튼들 숨기기 (화면 전환 전에 미리 처리)
        if isExpanded {
            toggleFloatingButtons()
        }
        
        // WriteOOTDViewController 생성
        let writeOotdViewController = WriteOOTDViewController()
        
        // NavigationController 존재 여부에 따라 처리
        if let navigationController = self.navigationController {
            print("✅ NavigationController 존재 - Push로 이동")
            navigationController.pushViewController(writeOotdViewController, animated: true)
            print("✅ Push 완료")
        } else {
            print("⚠️ NavigationController 없음 - Modal로 이동")
            let navController = UINavigationController(rootViewController: writeOotdViewController)
            navController.modalPresentationStyle = .fullScreen
            self.present(navController, animated: true) {
                print("✅ Modal Present 완료")
            }
        }
    }
    
    private func navigateToReviewViewController() {
        // 리뷰쓰기 화면으로 이동하는 로직
        print("리뷰쓰기 화면으로 이동")
        
        // 플로팅 버튼들 숨기기
        if isExpanded {
            toggleFloatingButtons()
        }
    }
    
    private func navigateToFreeBoardViewController() {
        // 자유게시판 글쓰기 화면으로 이동하는 로직
        print("자유게시판 글쓰기 화면으로 이동")
        
        // 플로팅 버튼들 숨기기
        if isExpanded {
            toggleFloatingButtons()
        }
    }
}

// MARK: - FloatingActionItemDelegate
extension SocialViewController: FloatingActionItemDelegate {
    func didTapFloatingActionItem(with title: String) {
        print("🔔 델리게이트 메서드 호출됨: \(title)")
        
        switch title {
        case "OOTD 글쓰기":
            print("📝 OOTD 글쓰기 케이스 매칭됨")
            navigateToOOTDViewController()
        case "리뷰쓰기":
            print("📝 리뷰쓰기 케이스 매칭됨")
            navigateToReviewViewController()
        case "자유게시판 글쓰기":
            print("📝 자유게시판 글쓰기 케이스 매칭됨")
            navigateToFreeBoardViewController()
        default:
            print("❓ 매칭되지 않은 타이틀: '\(title)'")
            break
        }
    }
}

//    @objc private func handleFloatingButtonTapped(_ notification: Notification) {
//        guard let title = notification.userInfo?["title"] as? String else { return }
//        
//        print("🔔 Notification으로 플로팅 버튼 탭 받음: \(title)")
//        
//        switch title {
//        case "OOTD 글쓰기":
//            navigateToOOTDViewController()
//        case "리뷰쓰기":
//            navigateToReviewViewController()
//        case "자유게시판 글쓰기":
//            navigateToFreeBoardViewController()
//        default:
//            break
//        }
//    }
//}

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
