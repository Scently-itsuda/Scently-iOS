//
//  NetworkServiceProtocol.swift
//  Scently
//
//  Created by 임재현 on 7/13/25.
//

import Moya
import CombineMoya
import Combine

protocol NetworkServiceProtocol {
    associatedtype Target: TargetType
    func request<T: Codable>(_ target: Target, responseType: T.Type) -> AnyPublisher<T, Error>
}
