//
//  FreeBoardDetailViewController.swift
//  Scently
//
//  Created by 임재현 on 8/15/25.
//

import UIKit
import SnapKit

final class FreeBoardDetailViewController: UIViewController {
    
    private var navigationView = FreeBoardNavigationView()
    private var userProfileView = FreeBoardUserProfileview()
    private var freeBoardContentView = FreeBoardContentView()
    private var freeBoardInteractionView = FreeBoardInteractionView()
    private var dividerView = DividerView(height:4)
    
    private var commentheaderView = OOTDCommentHeaderView()
    private var commentListView = CommentListView()
    private var commentTextView = CommentTextView()
    
    
    let mockComments = CommentResponse.mockData
    
    
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
        setupConstraints()
        configureComments()
        navigationView.delegate = self
    }
}

extension FreeBoardDetailViewController {
    private func setupUI() {
        self.view.addSubviews(
            navigationView,
            userProfileView,
            freeBoardContentView,
            freeBoardInteractionView,
            dividerView,
            commentheaderView,
            commentListView,
            commentTextView
        )
    }
    
    private func setupConstraints() {
        navigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(62)
        }
        
        userProfileView.snp.makeConstraints {
            $0.top.equalTo(navigationView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(41)
        }
        
        freeBoardContentView.snp.makeConstraints {
            $0.top.equalTo(userProfileView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        freeBoardInteractionView.snp.makeConstraints {
            $0.top.equalTo(freeBoardContentView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(freeBoardInteractionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
        }
        
        commentheaderView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
        }
        
        commentTextView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-20)
        }

        commentListView.snp.makeConstraints {
            $0.top.equalTo(commentheaderView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(commentTextView.snp.top).offset(-4)
        }
        
    }
}


// TODO: - 추후에 Scroll 관련해서 어떻게 바꿀지 몰라 남겨둠

//extension FreeBoardDetailViewController {
//    private func setupUI() {
//        self.view.addSubviews(
//            scrollView
//        )
//        self.scrollView.addSubview(
//            contentView
//        )
//        self.contentView.addSubviews(
//            navigationView,
//            userProfileView,
//            freeBoardContentView,
//            freeBoardInteractionView,
//            dividerView,
//            commentheaderView,
//            commentListView,
//            commentTextView
//        )
//    }
//    private func setupConstraints() {
//        
//        scrollView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//        }
//        
//        contentView.snp.makeConstraints {
//            $0.edges.equalToSuperview()
//            $0.width.equalToSuperview()
//            $0.height.greaterThanOrEqualTo(view.snp.height)
//        }
//        
//        navigationView.snp.makeConstraints {
//            $0.top.equalToSuperview()
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(62)
//        }
//        
//        userProfileView.snp.makeConstraints {
//            $0.top.equalTo(navigationView.snp.bottom).offset(8)
//            $0.leading.trailing.equalToSuperview().inset(20)
//            $0.height.equalTo(41)
//        }
//        
//        freeBoardContentView.snp.makeConstraints {
//            $0.top.equalTo(userProfileView.snp.bottom).offset(16)
//            $0.leading.trailing.equalToSuperview().inset(16)
//        }
//        
//        freeBoardInteractionView.snp.makeConstraints {
//            $0.top.equalTo(freeBoardContentView.snp.bottom).offset(16)
//            $0.leading.equalToSuperview().offset(16)
//        }
//        
//        dividerView.snp.makeConstraints {
//            $0.top.equalTo(freeBoardInteractionView.snp.bottom).offset(16)
//            $0.leading.trailing.equalToSuperview()
//        }
//        
//        commentheaderView.snp.makeConstraints {
//            $0.top.equalTo(dividerView.snp.bottom).offset(4)
//            $0.leading.trailing.equalToSuperview()
//        }
//        
//        commentListView.snp.makeConstraints {
//            $0.top.equalTo(commentheaderView.snp.bottom).offset(16)
//            $0.leading.trailing.equalToSuperview()
//            
//        }
//        
//        commentTextView.snp.makeConstraints {
//            $0.top.equalTo(commentListView.snp.bottom).offset(10)
//            $0.leading.trailing.equalToSuperview()
//            $0.height.equalTo(36)
//            $0.bottom.equalToSuperview().offset(-20)
//        }
//    }
//}

extension FreeBoardDetailViewController: FreeBoardNavigationViewDelegate {

    func didTapBackButton() {
        navigationController?.popViewController(animated: true)
    }
    
    func didTapAlertButton() {
        print("VC에서 alertButton 동작 전달받음")
    }
    
    private func configureComments() {
        commentListView.configure(with: mockComments)
    }
}
