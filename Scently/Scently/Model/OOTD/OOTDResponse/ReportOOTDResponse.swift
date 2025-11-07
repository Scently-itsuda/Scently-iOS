//
//  ReportOOTDResponse.swift
//  Scently
//
//  Created by 임재현 on 9/16/25.
//

import Foundation

typealias ReportOOTDResponse = BaseResponse<ReportData>
typealias ReportFreeBoardResponse = BaseResponse<ReportData>
typealias ReportCommentResponse = BaseResponse<ReportData>
typealias ReportReviewResponse = BaseResponse<ReportData>

struct ReportData: Codable {
    let reportId: Int
}
