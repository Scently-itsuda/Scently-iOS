//
//  OOTDDetailViewController.swift
//  Scently
//
//  Created by 임재현 on 8/8/25.
//

import UIKit
import SnapKit
import Combine

final class OOTDDetailViewController: UIViewController {
    
    private var navigationView = OOTDNavigationView()
    private var userProfileView = OOTDDetailUserProfileView()
    private var imageSliderView = ImageSliderView()
    private var postInteractionView = PostInteractionView()
    private var postContentView = PostContentView()
    private var productListView = ProductListView()
    
    private let viewModel = OOTDDetailViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.showsHorizontalScrollIndicator = false
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        setupConstraint()
        setupInteractions()
        setBinding()
        
        navigationView.delegate = self
    }
    
    private func setupUI() {
        self.view.addSubviews(scrollView)
        self.scrollView.addSubview(contentView)
        self.contentView
            .addSubviews(
                navigationView,
                userProfileView,
                imageSliderView,
                postInteractionView,
                postContentView,
                productListView
            )
    }
    
    private func setupConstraint() {
        

        scrollView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        navigationView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        userProfileView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(41)
        }
                
        imageSliderView.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(375)
        }
        
        postInteractionView.snp.makeConstraints {
            $0.top.equalTo(imageSliderView.snp.bottom).offset(16)
            $0.leading.equalTo(self.view.safeAreaLayoutGuide).offset(16)
            $0.height.equalTo(24)
        }
        
        postContentView.snp.makeConstraints {
            $0.top.equalTo(postInteractionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        productListView.snp.makeConstraints {
            $0.top.equalTo(postContentView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(240)
            $0.bottom.equalToSuperview().offset(-20)
            
        }
    }
    
    func configure(ootdId: Int) {
        viewModel.loadMockData(ootdId: ootdId)
    }
    
    private func setupInteractions() {
        postInteractionView.onLikeButtonTapped = {
            print("좋아요 버튼 클릭")
        }

        postInteractionView.onCommentButtonTapped = { [weak self] in
            print("댓글 버튼 클릭")
            let commentVC = OOTDCommentViewController()
            commentVC.modalPresentationStyle = .pageSheet
            
      
            if let sheet = commentVC.sheetPresentationController {
                sheet.detents = [
                    .custom { _ in
                        return UIScreen.main.bounds.height * 0.7
                    }
                ]
                sheet.prefersGrabberVisible = true
                sheet.preferredCornerRadius = 16
            }
            
            self?.present(commentVC, animated: true)
        }
        
        postContentView.configure(text: "실제 리뷰 텍스트가 여기에 들어갑니다. 매우 긴 텍스트일 수도 있고 짧을 수도 있습니다.실제 리뷰 텍스트가 여기에 들어갑니다. 매우실제 리뷰 텍스트가 여기에 들어갑니다. 매우 긴 텍스트일 수도 있고 짧을 수도 있습니다.실제 리뷰 텍스트가 여기에 들어갑니다. 매우실제 리뷰 텍스트가 여기에 들어갑니다. 매우 긴 텍스트일 수도 있고 짧을 수도 있습니다.실제 리뷰 텍스트가 여기에 들어갑니다. 매우")
    }
    
    private func setBinding() {
        viewModel.detailData
            .receive(on: DispatchQueue.main)
            .compactMap { $0 }
            .sink { [weak self] detailData in
                self?.updateUI(with: detailData)
            }
            .store(in: &cancellables)
    }
    
    private func updateUI(with data: OOTDDetailData) {
        userProfileView.configure(
            image: data.userInfo.profileImageUrl,
            nickName: data.userInfo.nickname,
            time: data.ootdInfo.createdAt.timeAgoString()
        )
        
        imageSliderView.configure(
            images: data.ootdInfo.ootdImageUrls
        )
        
        postInteractionView.configure(
            likeCount: data.ootdInfo.likeCount,
            commentCount: data.ootdInfo.commentCount,
            isLiked: data.ootdInfo.isLiked
        )
    }
}

extension OOTDDetailViewController: OOTDNavigationViewDelegate {

    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapAlertButton() {
        print("VC에서 alertButton 동작 전달받음")
    }
}
