//
//  OOTDDetailsResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

typealias OOTDDetailResponse = BaseResponse<OOTDDetailData>

// OOTD 상세 데이터
struct OOTDDetailData: Codable {
    let ootdInfo: OOTDInfo
    let userInfo: UserInfo
    let perfumeInfo: [PerfumeInfo]
}

// OOTD 기본 정보
struct OOTDInfo: Codable {
    let ootdId: Int
    let createdAt: Date
    let ootdImageUrls: [String]
    let likeCount: Int
    let commentCount: Int
    let volume: Int
    let content: String
    let tags: [String]
    let isLiked: Bool
}

// 사용자 정보
struct UserInfo: Codable {
    let gender: String
    let age: Int
}

// 향수 정보
struct PerfumeInfo: Codable {
    let perfumeId: Int
    let perfumeBrand: String
    let perfumeImageUrl: String
    let perfumeName: String
}
