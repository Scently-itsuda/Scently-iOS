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
    case registerFCMToken(fcmToken: String)
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
        case .registerFCMToken:
            return "/api/v1/fcm/token"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getNotifications:
            return .get
        case .registerFCMToken:
            return .put
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getNotifications(let page, let size):
            return .requestParameters(
                parameters: ["page": page, "size": size],
                encoding: URLEncoding.queryString
            )
            
        case .registerFCMToken(let fcmToken):
            return .requestParameters(
                parameters: ["fcmToken": fcmToken],
                encoding: JSONEncoding.default
            )
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
