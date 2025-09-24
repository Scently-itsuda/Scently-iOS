//
//  PerfumeListResponse.swift
//  Scently
//
//  Created by 임재현 on 7/20/25.
//

import Foundation
// MARK: - 향수 목록 조회 Responese Model
struct PerfumeResponse: Codable {
    let result: String
    let data: [Perfume]
    let error: String?
    let message: String
}

struct Perfume: Codable {
    let perfumeId: Int
    let name: String
    let imageURL: String
    let brand: String
}
