//
//  FCMTokenResponse.swift
//  Scently
//
//  Created by 임재현 on 9/17/25.
//

import Foundation

typealias FCMTokenResponse = BaseResponse<FCMTokenData>

struct FCMTokenData: Codable {
    let isSaved: Bool
}
