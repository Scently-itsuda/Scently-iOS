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
    case getAccords
    case getPerfumeDetail(perfumeId: Int)
    case addToWishList(perfumeId: Int, userId: Int) // ToDo: userId 고정일 경우 수정 
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
        case .getAccords:
            return "/api/v1/perfumes/accords"
        case .getPerfumeDetail(let perfumeId):
            return "/api/v1/perfumes/\(perfumeId)"
        case .addToWishList(perfumeId: let perfumeId, _):
            return "/api/v1/perfumes/\(perfumeId)/like"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getPerfumList,.getAccords,.getPerfumeDetail:
            return .get
        case .addToWishList:
            return .post
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getPerfumList,.getAccords,.getPerfumeDetail:
            return .requestPlain
        case .addToWishList(_ , let userId):
            return .requestParameters(
                parameters: ["userId": userId],
                encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        var headers = [
            "Content=Type:" : "application/json"
        ]
        
        return headers
    }
}
