//
//  LikeTarget.swift
//  Scently
//
//  Created by 임재현 on 9/14/25.
//

import Foundation
import Moya

enum LikeTarget {
    case getWishlistPerfumes(
        price: String?,
        gender: String?,
        accord: String?,
        potency: String?,
        brand: String?,
        country: String?,
        order: String?,
        page: Int,
        size: Int
    )
}

extension LikeTarget: TargetType {
    
    var baseURL: URL {
        guard let url = URL(string: AppConfig.shared.baseURL) else {
            fatalError("Invalid base URL")
        }
        return url
    }
    
    var path: String {
        
        switch self {
        case .getWishlistPerfumes:
            return "/api/v1/likes/perfumes"
        }
    }
    
    var method: Moya.Method {
        switch self {
        case .getWishlistPerfumes:
            return .get
        }
    }
    
    var task: Moya.Task {
        switch self {
        case .getWishlistPerfumes(let price, let gender, let accord, let potency, let brand, let country, let order, let page, let size):
            var parameters: [String: Any] = [
                "page": page,
                "size": size
            ]
            
            if let price = price, !price.isEmpty {
                parameters["price"] = price
            }
            if let gender = gender, !gender.isEmpty {
                parameters["gender"] = gender
            }
            if let accord = accord, !accord.isEmpty {
                parameters["accord"] = accord
            }
            if let potency = potency, !potency.isEmpty {
                parameters["potency"] = potency
            }
            if let brand = brand, !brand.isEmpty {
                parameters["brand"] = brand
            }
            if let country = country, !country.isEmpty {
                parameters["country"] = country
            }
            if let order = order, !order.isEmpty {
                parameters["order"] = order
            }
            
            return .requestParameters(parameters: parameters, encoding: URLEncoding.queryString)
        }
    }
    
    var headers: [String : String]? {
        var headers = [
            "Content-Type:" : "application/json"
        ]
        
        return headers
    }
}
