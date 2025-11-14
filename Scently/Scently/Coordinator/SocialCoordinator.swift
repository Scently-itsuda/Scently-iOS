//
//  SocialCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/14/25.
//

import Foundation
import UIKit

protocol SocialCoordinatorProtocol: AnyObject {
    /// OOTD 관련
    func showOOTDDetail(ootdId: Int)
    func showOOTDWrite()
    
    /// FreeBoard 관련
    func showFreeBoardDetail(postId: Int)
    func showFreeBoardWrite()
    
    /// Review 관련
    func showReviewWrite()
    func showReviewActionSheet(isMyReview:Bool,
                               onEdit: @escaping () -> Void,
                               onDelete: @escaping () -> Void,
                               onReport: @escaping () -> Void)
    func showReportReasonSheet(onReasonSelected: @escaping (ReportReason) -> Void)
    
    func showReportTextInput(reason: ReportReason, onSubmit: @escaping (String) -> Void)
}

class SocialCoordinator: Coordinator, SocialCoordinatorProtocol {

    var childCoordinators:[Coordinator] = []
    
    private let navigationController: UINavigationController
    private let authService: AuthServiceProtocol
    private let isGuestMode: Bool
    
    var onLoginRequired: (() -> Void)?
    
    init(navigationController: UINavigationController,
         authService: AuthServiceProtocol,
         isGusetMode: Bool) {

        self.navigationController = navigationController
        self.authService = authService
        self.isGuestMode = isGusetMode
        print("SocialCoordinator init")
    }
    
    deinit {
        print("SocialCoordinator deinit")

    }
    
    func start() {
        
    }
    
    
    func showOOTDDetail(ootdId: Int) {
        print("OOTD 상세화면 ID - \(ootdId)")
        let detailVC = OOTDDetailViewController()
        detailVC.configure(ootdId: ootdId)
        detailVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func showOOTDWrite() {
        print("OOTD 작성 화면")
        
        if isGuestMode {
            showLoginRequiredAlert {
                self.onLoginRequired?()
            }
            
            return
        }
        
        let writeVC = OOTDWriteViewController()
        writeVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(writeVC, animated: true)
    }
    
    func showFreeBoardDetail(postId: Int) {
        print("자유게시판 상세 화면 - ID: \(postId)")
        let detailVC = FreeBoardDetailViewController()
        detailVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(detailVC, animated: true)
    }
    
    func showFreeBoardWrite() {
        print("자유게시판 작성 화면")
        
        
        if isGuestMode {
            showLoginRequiredAlert {
                self.onLoginRequired?()
            }
            return
        }
        
        let writeVC = FreeBoardWriteViewController()
        writeVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(writeVC, animated: true)
    }
    
    func showReviewWrite() {
        print("리뷰 작성 화면")
        
        if isGuestMode {
            showLoginRequiredAlert {
                self.onLoginRequired?()
            }

            return
        }
        
        let writeVC = ReviewWriteViewController()
        writeVC.hidesBottomBarWhenPushed = true
        navigationController.navigationBar.isHidden = true
        navigationController.pushViewController(writeVC, animated: true)
    }
    
    func showReviewActionSheet(isMyReview: Bool,
                               onEdit: @escaping () -> Void,
                               onDelete: @escaping () -> Void,
                               onReport: @escaping () -> Void) {
        print("리뷰 Action Sheet")
        
        let sheet = ReviewActionBottomSheetViewController(isMyReview: isMyReview)
        
        sheet.onEditTapped = onEdit
        sheet.onDeleteTapped = onDelete
        sheet.onReportTapped = onReport
        
        sheet.modalPresentationStyle = .overFullScreen
        sheet.modalTransitionStyle = .crossDissolve
        navigationController.present(sheet, animated: true)
    }
    
    func showReportReasonSheet(onReasonSelected: @escaping (ReportReason) -> Void) {
        print("신고 사유 선택 Sheet")
        
        let sheet = ReportReasonBottomSheetViewController()
        
        sheet.onReasonSelected = onReasonSelected
        
        sheet.modalPresentationStyle = .overCurrentContext
        sheet.modalTransitionStyle = .crossDissolve
        navigationController.present(sheet, animated: true)
    }
    
    func showReportTextInput(reason: ReportReason, onSubmit: @escaping (String) -> Void) {
        print("신고 상세 입력")
    }
    
    private func showLoginRequiredAlert(onLogin: @escaping () -> Void) {
        let alert = UIAlertController(
            title: "로그인이 필요합니다",
            message: "글을 작성하려면 로그인이 필요합니다.\n로그인 하시겠습니까?",
            preferredStyle: .alert
        )
        
        let loginAction = UIAlertAction(title: "로그인", style: .default) { _ in
            onLogin()
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(cancelAction)
        alert.addAction(loginAction)
        
        navigationController.present(alert, animated: true)
    }
}
