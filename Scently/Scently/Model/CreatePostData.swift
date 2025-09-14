//
//  CreatePostData.swift
//  Scently
//
//  Created by 임재현 on 9/7/25.
//

import Foundation

typealias CreatePostResponse = BaseResponse<CreatedPostData>

struct CreatedPostData: Codable {
    let postId: Int
}
