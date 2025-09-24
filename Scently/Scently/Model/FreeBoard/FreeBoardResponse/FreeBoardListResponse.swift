//
//  FreeBoardListResponse.swift
//  Scently
//
//  Created by 임재현 on 9/7/25.
//

import Foundation

typealias FreeBoardListResponse = BaseResponse<FreeBoardListData>

struct FreeBoardListData: Codable {
   let dataList: [FreePost]
   let pageInfo: PageInfo
}

struct FreePost: Codable {
   let postId: Int
   let title: String
   let content: String
   let createdAt: Date
   let viewCount: Int
   let commentCount: Int
}
