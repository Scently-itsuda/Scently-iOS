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
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .reportOOTD:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .reportOOTD(_, let reportType, let otherReason):
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
