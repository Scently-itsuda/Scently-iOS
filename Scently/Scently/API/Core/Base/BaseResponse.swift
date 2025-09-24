//
//  BaseResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

struct BaseResponse<T: Codable>: Codable {
    let success: Bool
    let data: T?
    let error: ServerError?
    let message: String
}

struct ServerError: Codable {
    let code: String?
    let message: String?
}

extension BaseResponse {
    var isValid: Bool {
        return success && data != nil
    }
    
    var isSuccess: Bool {
        return success
    }
    
    var networkError: NetworkError? {
        guard let error = error else { return nil }
        return NetworkError.from(code: error.code, message: error.message)
    }
}
