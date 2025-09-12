//
//  FreeBoardCommentResponse.swift
//  Scently
//
//  Created by 임재현 on 9/13/25.
//

import Foundation


typealias PostFreeBoardCommentResponse = BaseResponse<FreeBoardCommentData>

struct FreeBoardCommentData: Codable {
    let commentId: Int
}
