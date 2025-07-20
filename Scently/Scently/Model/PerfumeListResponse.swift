//
//  PerfumeListResponse.swift
//  Scently
//
//  Created by 임재현 on 7/20/25.
//

import Foundation
// MARK: - 향수 목록 조회 Responese Model
struct PerfumeResponse: Codable {
    let success: Bool
    let data: PerfumeData?
    let error: APIError?
}

struct PerfumeData: Codable {
    let datalist: [Perfume]
    let pageInfo: PageInfo
}

struct Perfume: Codable {
    let perfumeId: Int64
    let name: String
    let imageURL: String
    let brand: String
}

struct PageInfo: Codable {
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
}

// MARK: - 에러 모델
struct APIError: Codable {
    let code: String
    let message: String
}
