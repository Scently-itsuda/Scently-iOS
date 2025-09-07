//
//  OOTDListResponse.swift
//  Scently
//
//  Created by 임재현 on 8/30/25.
//

import Foundation

typealias OOTDListResponse = BaseResponse<OOTDListData>

struct OOTDListData: Codable {
    let dataList: [OOTDItem]
    let pageInfo: PageInfo
}

struct OOTDItem: Codable {
    let ootdId: Int
    let ootdImageUrl: String
    let isLiked: Bool
}

struct PageInfo: Codable {
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
}
