//
//  LikedOOTDResponse.swift
//  Scently
//
//  Created by 임재현 on 9/14/25.
//

import Foundation

typealias LikedOOTDResponse = BaseResponse<LikedOOTDData>

struct LikedOOTDItem: Codable {
    let ootdId: Int
    let ootdImageUrl: String
}

struct LikedOOTDData: Codable {
    let dataList: [LikedOOTDItem]
    let pageInfo: PageInfo
}
