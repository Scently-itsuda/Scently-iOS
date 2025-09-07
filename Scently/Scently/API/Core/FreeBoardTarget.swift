//
//  FreeBoardTarget.swift
//  Scently
//
//  Created by 임재현 on 9/7/25.
//

import Foundation
import Moya

enum FreeBoardTarget {
    case getFreeBoardList(order: String, page:Int, size: Int)
}

extension FreeBoardTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: AppConfig.shared.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getFreeBoardList:
            return "/api/v1/posts"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFreeBoardList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getFreeBoardList(let order, let page, let size):
            return .requestParameters(
                parameters: [
                    "order": order,
                    "page": page,
                    "size": size
                ],
                encoding: URLEncoding.queryString
            )
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

