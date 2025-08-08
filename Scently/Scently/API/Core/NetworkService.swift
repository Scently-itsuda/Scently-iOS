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
    
    init(provider: MoyaProvider<Target>? = nil) {
        if let provider = provider {
            self.provider = provider
        } else {
            var plugins: [PluginType] = []
            
            #if DEBUG
            // Debug 모드에서만 로거 추가
            let loggerPlugin = NetworkLoggerPlugin(configuration: .init(
                logOptions: [.requestBody, .requestHeaders, .verbose]
            ))
            plugins.append(loggerPlugin)
            #endif
            
            self.provider = MoyaProvider<Target>(plugins: plugins)
        }
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
