//
//  OOTDDetailViewController.swift
//  Scently
//
//  Created by 임재현 on 8/8/25.
//

import UIKit
import SnapKit

final class OOTDDetailViewController: UIViewController {
    
    private var navigationView = OOTDNavigationView()
    private var userProfileView = OOTDDetailUserProfileView()
    private var imageSliderView = ImageSliderView()
    private var postInteractionView = PostInteractionView()
    private var postContentView = PostContentView()
    
    private let perfumeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "미스 디올 오 드 퍼퓸"
        label.font = .pretendard(.bold, size: 16)
        label.textColor = .black
        return label
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemMint
        setupUI()
        setupConstraint()
        setupInteractions()
        
        navigationView.delegate = self
    }
    
    private func setupUI() {
        self.view
            .addSubviews(
                navigationView,
                userProfileView,
                perfumeTitleLabel,
                imageSliderView,
                postInteractionView,
                postContentView
            )
    }
    
    private func setupConstraint() {
        
        navigationView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        userProfileView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(41)
        }
                
        perfumeTitleLabel.snp.makeConstraints {
            $0.centerY.centerX.equalToSuperview()
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
            $0.top.equalTo(postInteractionView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.height.greaterThanOrEqualTo(50)

        }
    }
    
    func configure(num: String) {
        self.perfumeTitleLabel.text = num
    }
    
    private func setupInteractions() {
        postInteractionView.onLikeButtonTapped = {
            print("좋아요 버튼 클릭")
        }
        
        postInteractionView.onCommentButtonTapped = {
            print("댓글 버튼 클릭")
        }
        
        postContentView.configure(text: "실제 리뷰 텍스트가 여기에 들어갑니다. 매우 긴 텍스트일 수도 있고 짧을 수도 있습니다.실제 리뷰 텍스트가 여기에 들어갑니다. 매우")
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
