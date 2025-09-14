//
//  FreeBoardCommentsResponse.swift
//  Scently
//
//  Created by 임재현 on 9/13/25.
//

import Foundation

typealias FreeBoardCommentsResponse = BaseResponse<FreeBoardCommentsData>

struct FreeBoardCommentsData: Codable {
    let commentInfos: [CommentInfo]
    let totalCommentCount: Int
}
