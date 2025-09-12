//
//  CreateFreeBoardCommentRequest.swift
//  Scently
//
//  Created by 임재현 on 9/13/25.
//

import Foundation

struct CreateFreeBoardCommentRequest: Codable {
    let commentId: Int?
    let comment: String  
}
