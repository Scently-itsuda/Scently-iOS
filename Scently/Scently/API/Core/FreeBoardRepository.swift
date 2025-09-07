//
//  FreeBoardRepository.swift
//  Scently
//
//  Created by 임재현 on 9/7/25.
//

import Foundation
import Moya
import Combine

protocol FreeBoardRepositoryProtocol {
    func getFreeBoardList(order: String, page:Int, size: Int) -> AnyPublisher<FreeBoardListData,Error>
}


class FreeBoardRepository: FreeBoardRepositoryProtocol {
   
    private let networkService: NetworkService<FreeBoardTarget>
    
    init(networkService: NetworkService<FreeBoardTarget> = NetworkService<FreeBoardTarget>()) {
        self.networkService = networkService
    }
    
    
    func getFreeBoardList(order: String, page: Int, size: Int) -> AnyPublisher<FreeBoardListData,Error> {
        return networkService.request(.getFreeBoardList(order: order, page: page, size: size), responseType: FreeBoardListResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data ?? FreeBoardListData(dataList: [], pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0))
            }
            .handleEvents(receiveOutput: { ootdListData in
                print("Successfully loaded \(ootdListData.dataList.count) OOTDs")
            })
            .catch { error -> AnyPublisher<FreeBoardListData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load OOTD list: \(networkError.errorDescription ?? "")")
                } else {
                    print("Failed to load OOTD list: \(error.localizedDescription)")
                }
                return Just(FreeBoardListData(dataList: [], pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
        }
    }
