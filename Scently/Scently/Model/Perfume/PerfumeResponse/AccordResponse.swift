//
//  AccordResponse.swift
//  Scently
//
//  Created by 임재현 on 7/20/25.
//

import Foundation

// MARK: - 향수 Accord 조회
struct AccordResponse: Codable {
    let result: String
    let data: [Accord]
    let error: String?
    let message: String
}

struct Accord: Codable {
    let accordId: Int
    let name: String
}
