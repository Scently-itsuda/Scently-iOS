//
//  OOTDPerfumeResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

struct OOTDPerfumeResponse: Codable {
    let success: Bool
    let data: OOTDPerfumeData?
    let error: String?
    let message: String
}

struct OOTDPerfumeData: Codable {
    let perfumes: [PerfumeItem]
}

struct PerfumeItem: Codable {
    let perfumeId: Int
    let imageUri: String
    let brand: String
    let name: String
}
