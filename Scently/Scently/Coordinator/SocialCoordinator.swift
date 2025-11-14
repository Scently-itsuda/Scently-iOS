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
    private let isGusetMode: Bool
    
    var onLoginRequired: (() -> Void)?
    
    init(navigationController: UINavigationController,
         authService: AuthServiceProtocol,
         isGusetMode: Bool) {

        self.navigationController = navigationController
        self.authService = authService
        self.isGusetMode = isGusetMode
    }
    
    deinit {
        print("SocialCoordinator deinit")

    }
    
    func start() {
        
    }
    
    
    func showOOTDDetail(ootdId: Int) {
        print("OOTD 상세화면 ID - \(ootdId)")
    }
    
    func showOOTDWrite() {
        print("OOTD 작성 화면")
    }
    
    func showFreeBoardDetail(postId: Int) {
        print("자유게시판 상세 화면 - ID: \(postId)")
    }
    
    func showFreeBoardWrite() {
        print("자유게시판 작성 화면")
    }
    
    func showReviewWrite() {
        print("리뷰 작성 화면")
    }
    
    func showReviewActionSheet(isMyReview: Bool,
                               onEdit: @escaping () -> Void,
                               onDelete: @escaping () -> Void,
                               onReport: @escaping () -> Void) {
        print("리뷰 Action Sheet")
    }
    
    func showReportReasonSheet(onReasonSelected: @escaping (ReportReason) -> Void) {
        print("신고 사유 선택 Sheet")
    }
    
    func showReportTextInput(reason: ReportReason, onSubmit: @escaping (String) -> Void) {
        print("신고 상세 입력")
    }
}
