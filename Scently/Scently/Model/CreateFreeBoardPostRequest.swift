//
//  CreateFreeBoardPostRequest.swift
//  Scently
//
//  Created by 임재현 on 9/7/25.
//

import Foundation

struct CreateFreeBoardPostRequest: Codable {
    let title: String
    let content: String
    let tagNames: [String]
}
