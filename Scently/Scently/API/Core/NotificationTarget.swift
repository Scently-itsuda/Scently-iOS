//
//  NotificationTarget.swift
//  Scently
//
//  Created by 임재현 on 9/17/25.
//

import Foundation
import Moya

enum NotificationTarget {
    case getNotifications(page: Int, size: Int)
}

extension NotificationTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: AppConfig.shared.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    
    var path: String {
        switch self {
        case .getNotifications(let page, let size):
            return "/api/v1/notifications"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNotifications(let page, let size):
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getNotifications(let page, let size):
            return .requestParameters(
                parameters: ["page": page, "size": size],
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
