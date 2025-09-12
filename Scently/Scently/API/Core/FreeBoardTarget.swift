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
    case postFreeBoard(title: String, content: String, tagNames: [String])
    case getDetailFreeBoard(postID: Int)
    case deleteFreeBoard(postId: Int)
    case likeFreeBoardPost(postId: Int)
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
        case .postFreeBoard:
            return "/api/v1/posts"
        case .getDetailFreeBoard(let postId):
            return "/api/v1/posts/\(postId)"
        case .deleteFreeBoard(let postId):
            return "/api/v1/posts/\(postId)"
        case .likeFreeBoardPost(let postId):
            return "/api/v1/posts/\(postId)"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getFreeBoardList, .getDetailFreeBoard:
            return .get
        case .postFreeBoard,.likeFreeBoardPost:
            return .post
        case .deleteFreeBoard:
            return .delete
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
        case .postFreeBoard(let title, let content, let tagNames):
            let requestBody = CreateFreeBoardPostRequest(title: title, content: content, tagNames: tagNames)
            return .requestJSONEncodable(requestBody)
        case .getDetailFreeBoard, .deleteFreeBoard, .likeFreeBoardPost:
            return .requestPlain
        }
    }
    
    var headers: [String : String]? {
        return [
            "Content-Type": "application/json"
        ]
    }
}

