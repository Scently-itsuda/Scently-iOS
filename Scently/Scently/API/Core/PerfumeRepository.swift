//
//  PerfumeRepository.swift
//  Scently
//
//  Created by 임재현 on 7/21/25.
//

import Foundation
import Moya
import Combine

protocol PerfumeRepository {
    func getPerfumes() -> AnyPublisher<[Perfume], Error>
}

class DefaultPerfumeRepository: PerfumeRepository {
    private let networkService: NetworkService<PerfumeTarget>
    
    init(networkService: NetworkService<PerfumeTarget> = NetworkService<PerfumeTarget>()) {
        self.networkService = networkService
    }
    
    func getPerfumes() -> AnyPublisher<[Perfume], Error> {
        return networkService.request(.getPerfumList, responseType: [Perfume].self)
            .handleEvents(receiveOutput: { perfumes in
                print("Successfully loaded \(perfumes.count) perfumes")
            })
            .catch { error -> AnyPublisher<[Perfume], Error> in
                print("Failed to load perfumes: \(error.localizedDescription)")
                return Just([Perfume]())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
