//
//  NetworkService.swift
//  Scently
//
//  Created by 임재현 on 7/13/25.
//

import Moya
import Combine
import Foundation

class NetworkService<Target: TargetType>: NetworkServiceProtocol {
    
    private let provider: MoyaProvider<Target>
    
    init(provider: MoyaProvider<Target> = MoyaProvider<Target>()) {
        self.provider = provider
    }
    
    func request<T: Codable>(_ target: Target, responseType: T.Type) -> AnyPublisher<T, Error> {
        return provider.requestPublisher(target)
            .map { response in
                if let jsonString = String(data: response.data, encoding: .utf8) {
                    print("Raw JSON Response: \(jsonString)")
                }
                return response.data
            }
            .decode(type: T.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
    
}
