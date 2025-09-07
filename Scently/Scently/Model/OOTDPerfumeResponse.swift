//
//  OOTDPerfumeResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

typealias OOTDPerfumeResponse = BaseResponse<OOTDPerfumeData>

struct OOTDPerfumeData: Codable {
    let perfumes: [PerfumeItem]
}

struct PerfumeItem: Codable {
    let perfumeId: Int
    let imageUri: String
    let brand: String
    let name: String
}
