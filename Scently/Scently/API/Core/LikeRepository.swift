//
//  LikeRepository.swift
//  Scently
//
//  Created by 임재현 on 9/14/25.
//

import Foundation
import Moya
import Combine

protocol LikeRepositoryProtocol {
    func getWishlistPerfumes(
        price: String?,
        gender: String?,
        accord: String?,
        potency: String?,
        brand: String?,
        country: String?,
        order: String?,
        page: Int,
        size: Int
    ) -> AnyPublisher<PerfumeWishlistData, Error>
    
    func getLikedOOTDs(
        order: String?,
        page: Int,
        size: Int
    ) -> AnyPublisher<LikedOOTDData, Error>
}

class LikeRepository: LikeRepositoryProtocol {
   
    private let networkService: NetworkService<LikeTarget>
    
    init(networkService: NetworkService<LikeTarget> = NetworkService<LikeTarget>()) {
        self.networkService = networkService
    }
    
    func getWishlistPerfumes(
        price: String?,
        gender: String?,
        accord: String?,
        potency: String?,
        brand: String?,
        country: String?,
        order: String?,
        page: Int,
        size: Int
    ) -> AnyPublisher<PerfumeWishlistData, Error> {
        return networkService.request(
            .getWishlistPerfumes(
                price: price,
                gender: gender,
                accord: accord,
                potency: potency,
                brand: brand,
                country: country,
                order: order,
                page: page,
                size: size
            ),
            responseType: PerfumeWishlistResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? PerfumeWishlistData(
                dataList: [],
                pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)
            )
        }
        .handleEvents(receiveOutput: { wishlistData in
            print("Successfully loaded \(wishlistData.dataList.count) wishlist perfumes")
        })
        .catch { error -> AnyPublisher<PerfumeWishlistData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to load wishlist perfumes: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to load wishlist perfumes: \(error.localizedDescription)")
            }
            return Just(PerfumeWishlistData(
                dataList: [],
                pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)
            ))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    func getLikedOOTDs(
        order: String?,
        page: Int,
        size: Int
    ) -> AnyPublisher<LikedOOTDData, Error> {
        return networkService.request(
            .getLikedOOTDs(
                order: order,
                page: page,
                size: size
            ),
            responseType: LikedOOTDResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? LikedOOTDData(
                dataList: [],
                pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)
            )
        }
        .handleEvents(receiveOutput: { likedOOTDData in
            print("Successfully loaded \(likedOOTDData.dataList.count) liked OOTDs")
        })
        .catch { error -> AnyPublisher<LikedOOTDData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to load liked OOTDs: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to load liked OOTDs: \(error.localizedDescription)")
            }
            return Just(LikedOOTDData(
                dataList: [],
                pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)
            ))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
}
