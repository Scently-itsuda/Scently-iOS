//
//  OOTDRepository.swift
//  Scently
//
//  Created by 임재현 on 8/30/25.
//

import Foundation
import Moya
import Combine

protocol OOTDRepositoryProtocol {
    func getOOTDList(order: String, page: Int, size: Int) -> AnyPublisher<OOTDListData, Error>
}

class OOTDRepository: OOTDRepositoryProtocol {

    
    private let networkService: NetworkService<OOTDTarget>
    
    init(networkService: NetworkService<OOTDTarget> = NetworkService<OOTDTarget>()) {
        self.networkService = networkService
    }
    
    func getOOTDList(order: String, page: Int, size: Int) -> AnyPublisher<OOTDListData, Error> {
        return networkService
            .request(.getOOTDList(order: order, page: page, size: size),
                    responseType: OOTDListResponse.self)
            .map { response in
                return response.data ?? OOTDListData(dataList: [], pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0))
            }
            .handleEvents(receiveOutput: { ootdListData in
                print("Successfully loaded \(ootdListData.dataList.count) OOTDs")
            })
            .catch { error -> AnyPublisher<OOTDListData, Error> in
                print("Failed to load OOTD list: \(error.localizedDescription)")
                return Just(OOTDListData(dataList: [], pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
