//
//  ReportTarget.swift
//  Scently
//
//  Created by 임재현 on 9/16/25.
//

import Foundation
import Moya

enum ReportTarget {
    case reportOOTD(ootdId: String,reportType:String,otherReason:String?)
    case reportFreeBoard(postId: String, reportType: String, otherReason: String?)
    case reportComment(commentId: String, reportType: String, otherReason: String?)
}

extension ReportTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: AppConfig.shared.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        switch self {
        case .reportOOTD(let ootdId, _, _):
            return "/api/v1/reports/ootds/\(ootdId)"
        case .reportFreeBoard(let postId, _, _):
            return "/api/v1/reports/posts/\(postId)"
        case .reportComment(let commentId, _ , _):
            return "/api/v1/reports/comments/\(commentId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reportOOTD, .reportFreeBoard, .reportComment:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .reportOOTD(_, let reportType, let otherReason),
             .reportFreeBoard(_, let reportType, let otherReason),
             .reportComment(_, let reportType, let otherReason):
            
            var parameters: [String: Any] = ["reportType": reportType]
            if let otherReason = otherReason {
                parameters["otherReason"] = otherReason
            }
            return .requestParameters(parameters: parameters, encoding: JSONEncoding.default)
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}
