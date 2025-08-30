//
//  OOTDTarget.swift
//  Scently
//
//  Created by 임재현 on 8/30/25.
//

import Foundation
import Moya

enum OOTDTarget {
    case getOOTDList(order: String, page: Int, size: Int)
}

extension OOTDTarget: TargetType {
    var baseURL: URL {
        guard let url = URL(string: AppConfig.shared.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
            
        case .getOOTDList:
            return "/api/v1/ootds"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .getOOTDList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getOOTDList(let order, let page, let size):
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
        var headers = [
            "Content=Type:" : "application/json"
        ]
        
        return headers
    }
}
