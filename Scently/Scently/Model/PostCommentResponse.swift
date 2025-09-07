//
//  PostCommentResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

typealias PostCommentResponse = BaseResponse<PostCommentData>


struct PostCommentData: Codable {
    let commentId: Int
}
