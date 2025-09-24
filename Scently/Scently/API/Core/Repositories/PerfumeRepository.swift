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
    func getPerfumes(filters: PerfumeFilterParameters?) -> AnyPublisher<[Perfume], Error>
    func getPerfumeDetail(id: Int) -> AnyPublisher<PerfumeDetail, Error>
    func getPerfumeReview(id: Int, page: Int, size: Int) -> AnyPublisher<PerfumeReviewData, Error>
}

class DefaultPerfumeRepository: PerfumeRepository {
    private let networkService: NetworkService<PerfumeTarget>
    
    init(networkService: NetworkService<PerfumeTarget> = NetworkService<PerfumeTarget>()) {
        self.networkService = networkService
    }
    
    func getPerfumes(filters: PerfumeFilterParameters?) -> AnyPublisher<[Perfume], Error> {
        return networkService.request(.getPerfumList(filters: filters), responseType: PerfumeResponse.self)
            .map(\.data)
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
    
    func getPerfumeDetail(id: Int) -> AnyPublisher<PerfumeDetail, Error> {
        return networkService.request(.getPerfumeDetail(perfumeId: id), responseType: PerfumeDetailResponse.self)
            .map(\.data)
            .handleEvents(receiveOutput: { detail in
                print("Successfully loaded detail for perfume \(id)")
            })
            .catch { error -> AnyPublisher<PerfumeDetail, Error> in
                print("Failed to load perfume detail: \(error.localizedDescription)")
                return Fail(error: error).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getPerfumeReview(id: Int, page: Int, size: Int) -> AnyPublisher<PerfumeReviewData, any Error> {
        return networkService.request(.getPerfumeReview(perfumeId: id, page: page, size: size), responseType: PerfumeReviewResPonse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data ?? PerfumeReviewData(nickname: "")
            }
            .handleEvents(receiveOutput: { reviewData in
                print("Successfully loaded \(reviewData.nickname) reviews")
            })
            .catch { error -> AnyPublisher<PerfumeReviewData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load OOTD list: \(networkError.errorDescription ?? "")")
                } else {
                    print("Failed to load OOTD list: \(error.localizedDescription)")
                }
                return Just(PerfumeReviewData(nickname: ""))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
