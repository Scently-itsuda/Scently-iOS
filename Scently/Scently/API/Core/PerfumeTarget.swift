//
//  PerfumeTarget.swift
//  Scently
//
//  Created by 임재현 on 7/13/25.
//

import Foundation
import Moya

enum PerfumeTarget {
    case getPerfumList
}


extension PerfumeTarget: TargetType {
    var baseURL: URL {
        guard let url = URL(string: AppConfig.shared.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .getPerfumList:
            return "/api/v1/perfumes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPerfumList:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPerfumList:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers = [
            "Content=Type:" : "application/json"
        ]
        
        return headers
    }
    
    
}
