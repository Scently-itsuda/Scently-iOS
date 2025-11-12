//
//  MyViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class MyViewController: UIViewController {
        
    weak var coordinator: MainTabCoordinatorProtocol?
    var isGuestMode:Bool = false
    
    private var myPageHeaderView = MyPageHeaderView()
    private var myPageProfileView = MyPageProfileView()
    private var recentProductsView = RecentProductsView()
    private var myPageTableView = MyPageTableView()
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        if isGuestMode {
            checkLoginRequired()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        self.view.backgroundColor = .white
        print("MyViewController init")
        myPageHeaderView.delegate = self
        myPageProfileView.delegate = self
        myPageTableView.delegate = self
        recentProductsView.delegate = self
    }
    
    private func checkLoginRequired() {
        coordinator?.requiresLogin { [weak self] shouldLogin in
            if shouldLogin {
                print("로그인 화면 이동 필요")
                self?.coordinator?.showLoginScreen()
            } else {
                print("취소 - 다른 탭으로 이동 필요")
                self?.navigationController?.tabBarController?.selectedIndex = 2
            }
        }
    }
    
    
}


extension MyViewController {
    private func setupUI() {
        self.view.addSubviews(
            myPageHeaderView,
            myPageProfileView,
            recentProductsView,
            myPageTableView
        )
    }
    private func setupConstraints() {
        myPageHeaderView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        myPageProfileView.snp.makeConstraints {
            $0.top.equalTo(myPageHeaderView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(64)
        }
        
        recentProductsView.snp.makeConstraints {
            $0.top.equalTo(myPageProfileView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(240)
        }
        
        myPageTableView.snp.makeConstraints {
            $0.top.equalTo(recentProductsView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(300)
            
        }
    }
}

extension MyViewController: MyPageActionDelegate,MyPageProfileViewDelegate {
    func alertButtonDidTap() {
        print("Alert Button Did Tapped")
    }
    
    func profileEditButtonDidTap() {
        let profileEditVC = ProfileEditViewController()
        self.navigationController?.navigationBar.isHidden = true
        profileEditVC.hidesBottomBarWhenPushed = true
        navigationController?.pushViewController(profileEditVC, animated: false)
    }
}

extension MyViewController: MyPageTableViewDelegate {
    
    func didSelectNotificationSettings() {
        let notificationVC = NotificationSettingsViewController()
        navigationController?.pushViewController(notificationVC, animated: true)
    }
    
    func didSelecteNotices() {
        let noticeVC = NoticeViewController()
        navigationController?.pushViewController(noticeVC, animated: true)
    }
    
    func didSelectLogout() {
        coordinator?.logout()
    }
}

extension MyViewController: RecentProductsViewDelegate {
    func didTapRecentProducts() {
        let recentlyViewedVC = RecentlyViewedViewController()
        navigationController?.pushViewController(recentlyViewedVC, animated: true)
    }
}
