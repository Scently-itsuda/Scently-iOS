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
    case createOOTD(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data])
    case getOOTDPerfume(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data])
    case getOOTDDetails(ootdId: Int)
    case deleteOOTD(ootdId: Int)
    case likeOOTD(ootdId: Int)
    
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
        case .createOOTD:
            return "/api/v1/ootds"
        case .getOOTDPerfume:
            return "/api/v1/ootds/perfumes"
        case .getOOTDDetails(let ootdId):
            return "/api/v1/ootds/\(ootdId)"
        case .deleteOOTD(let ootdId):
            return "/api/v1/ootds/\(ootdId)"
        case .likeOOTD(let ootdId):
            return "/api/v1/ootds/\(ootdId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
            
        case .getOOTDList, .getOOTDPerfume, .getOOTDDetails:
            return .get
        case .createOOTD, .likeOOTD:
            return .post
        case .deleteOOTD:
            return .delete
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
            
        case .createOOTD(let content, let volume, let perfumeIds, let tagNames, let images),
                .getOOTDPerfume(let content, let volume, let perfumeIds, let tagNames, let images):
               return createMultipartTask(content: content, volume: volume, perfumeIds: perfumeIds, tagNames: tagNames, images: images)
            
        case .getOOTDDetails, .deleteOOTD:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        var headers: [String: String] = [:]
        
        switch self {
        case .getOOTDList, .getOOTDDetails, .deleteOOTD, .likeOOTD:
            headers["Content-Type"] = "application/json"
            
        case .createOOTD, .getOOTDPerfume:
            headers["Content-Type"] = "multipart/form-data"
        }
        
        if needsAuthentication {
            if let token = TokenManager.shared.accessToken {
                headers["Authorization"] = "Bearer \(token)"
            }
        }
        
        return headers
    }

    private var needsAuthentication: Bool {
        switch self {
        case .getOOTDList:
            return false
        default:
            return true

        }
    }
    
    private func createMultipartTask(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data]) -> Moya.Task {
        var multipartData: [MultipartFormData] = []
        
        let jsonData: [String: Any] = [
            "content": content,
            "volume": volume,
            "perfumeIds": perfumeIds,
            "tagNames": tagNames
        ]
        
        if let jsonDataEncoded = try? JSONSerialization.data(withJSONObject: jsonData) {
            multipartData.append(MultipartFormData(provider: .data(jsonDataEncoded), name: "data", mimeType: "application/json"))
        }
        
        for (index, imageData) in images.enumerated() {
            multipartData.append(MultipartFormData(provider: .data(imageData),
                                                 name: "images",
                                                 fileName: "image\(index).jpg",
                                                 mimeType: "image/jpeg"))
        }
        
        return .uploadMultipart(multipartData)
    }
}


#warning("추후 KeyChain 로직으로 변경")
class TokenManager {
    static let shared = TokenManager()
    private init() {}
    
    var accessToken: String? {
        return UserDefaults.standard.string(forKey: "access_token")
    }
}
