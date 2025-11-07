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

extension OOTDListData {
    static var mockData: OOTDListData {
        return OOTDListData(
            dataList: [
                OOTDItem(
                    ootdId: 1,
                    ootdImageUrl: "https://picsum.photos/300/400?random=1",
                    isLiked: true
                ),
                OOTDItem(
                    ootdId: 2,
                    ootdImageUrl: "https://picsum.photos/300/400?random=2",
                    isLiked: false
                ),
                OOTDItem(
                    ootdId: 3,
                    ootdImageUrl: "https://picsum.photos/300/400?random=3",
                    isLiked: true
                ),
                OOTDItem(
                    ootdId: 4,
                    ootdImageUrl: "https://picsum.photos/300/400?random=4",
                    isLiked: false
                ),
                OOTDItem(
                    ootdId: 5,
                    ootdImageUrl: "https://picsum.photos/300/400?random=5",
                    isLiked: true
                ),
                OOTDItem(
                    ootdId: 6,
                    ootdImageUrl: "https://picsum.photos/300/400?random=6",
                    isLiked: false
                ),
                OOTDItem(
                    ootdId: 7,
                    ootdImageUrl: "https://picsum.photos/300/400?random=7",
                    isLiked: false
                ),
                OOTDItem(
                    ootdId: 8,
                    ootdImageUrl: "https://picsum.photos/300/400?random=8",
                    isLiked: true
                ),
                OOTDItem(
                    ootdId: 9,
                    ootdImageUrl: "https://picsum.photos/300/400?random=9",
                    isLiked: false
                ),
                OOTDItem(
                    ootdId: 10,
                    ootdImageUrl: "https://picsum.photos/300/400?random=10",
                    isLiked: true
                )
            ],
            pageInfo: PageInfo(
                page: 1,
                size: 10,
                totalElements: 47,
                totalPages: 5
            )
        )
    }
}

