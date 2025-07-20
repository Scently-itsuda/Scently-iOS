//
//  PerfumeDetailResponse.swift
//  Scently
//
//  Created by 임재현 on 7/20/25.
//

import Foundation

// MARK: - 향수 상세 정보 Responese Model
struct PerfumeDetailResponse: Codable {
    let result: String
    let data: PerfumeDetail
    let error: String?
    let message: String
}

struct PerfumeDetail: Codable {
    let perfumeId: Int
    let imageURL: String
    let brand: String
    let name: String
    let perfumeVolumes: [PerfumeVolume]
    let potential: String
    let accords: PerfumeAccords
    let description: String
    let detail: String
}

struct PerfumeVolume: Codable {
    let id: Int
    let volume: Int
    let price: Int
}

struct PerfumeAccords: Codable {
    let topNotes: [Note]
    let middleNotes: [Note]
    let baseNotes: [Note]
    let unknownNotes: [Note]
}

struct Note: Codable {
    let id: Int
    let name: String
}
