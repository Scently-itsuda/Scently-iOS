//
//  SocialCoordinator.swift
//  Scently
//
//  Created by 임재현 on 11/14/25.
//

import Foundation

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
