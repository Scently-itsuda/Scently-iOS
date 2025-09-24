//
//  DeleteOOTDResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

typealias DeleteOOTDResponse = BaseResponse<EmptyData>
typealias LikeOOTDResponse = BaseResponse<EmptyData>
typealias LikeCommentResponse = BaseResponse<EmptyData>
typealias DeleteCommentResponse = BaseResponse<EmptyData>

struct EmptyData: Codable {}
