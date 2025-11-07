//
//  PerfumeReviewResPonse.swift
//  Scently
//
//  Created by 임재현 on 9/24/25.
//

import Foundation

typealias PerfumeReviewResPonse = BaseResponse<PerfumeReviewData>

struct PerfumeReviewData: Codable {
    let nickname: String
}
