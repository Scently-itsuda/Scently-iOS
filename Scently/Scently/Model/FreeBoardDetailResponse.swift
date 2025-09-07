//
//  FreeBoardDetailResponse.swift
//  Scently
//
//  Created by 임재현 on 9/7/25.
//

import Foundation

typealias FreeBoardDetailResponse = BaseResponse<FreeBoardDetailData>

struct FreeBoardDetailData: Codable {
   let postInfo: FreeBoardPostInfo
   let userInfo: FreeBoardUserInfo
}

struct FreeBoardPostInfo: Codable {
   let title: String
   let content: String
   let createdAt: Data
   let likeCount: Int
   let viewCount: Int
   let commentCount: Int
}

struct FreeBoardUserInfo: Codable {
   let userId: Int
   let profileImageUrl: String
   let nickname: String
}
