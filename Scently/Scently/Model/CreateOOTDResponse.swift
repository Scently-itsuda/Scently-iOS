//
//  CreateOOTDResponse.swift
//  Scently
//
//  Created by 임재현 on 8/30/25.
//

import Foundation

struct CreateOOTDResponse: Codable {
    let success: Bool
    let data: CreateOOTDData?
    let error: String?
    let message: String
}

struct CreateOOTDData: Codable {
    let ootdId: Int
}
