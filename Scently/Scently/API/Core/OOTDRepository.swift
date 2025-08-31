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
    func createOOTD(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data]) -> AnyPublisher<Int, Error>
    func getOOTDPerfume(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data]) -> AnyPublisher<[PerfumeItem], Error>
    func getOOTDDetail(ootdId: Int) -> AnyPublisher<OOTDDetailData, Error>
}

class OOTDRepository: OOTDRepositoryProtocol {

    
    private let networkService: NetworkService<OOTDTarget>
    
    init(networkService: NetworkService<OOTDTarget> = NetworkService<OOTDTarget>()) {
        self.networkService = networkService
    }
    
    //MARK: - OOTD 목록 조회
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
    
    //MARK: - OOTD 게시글 작성
    func createOOTD(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data]) -> AnyPublisher<Int, Error> {
        return networkService
            .request(.createOOTD(content: content, volume: volume, perfumeIds: perfumeIds, tagNames: tagNames, images: images),
                    responseType: CreateOOTDResponse.self)
            .map { response in
                return response.data?.ootdId ?? 0
            }
            .handleEvents(receiveOutput: { ootdId in
                print("Successfully created OOTD with ID: \(ootdId)")
            })
            .catch { error -> AnyPublisher<Int, Error> in
                print("Failed to create OOTD: \(error.localizedDescription)")
                return Just(0)
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    //MARK: - OOTD 향수 조회
    
    func getOOTDPerfume(content: String, volume: Int, perfumeIds: [Int], tagNames: [String], images: [Data]) -> AnyPublisher<[PerfumeItem], Error> {
        return networkService
            .request(.getOOTDPerfume(content: content, volume: volume, perfumeIds: perfumeIds, tagNames: tagNames, images: images),
                    responseType: OOTDPerfumeResponse.self)
            .map { response in
                return response.data?.perfumes ?? []
            }
            .handleEvents(receiveOutput: { perfumes in
                print("Successfully loaded \(perfumes.count) perfumes for OOTD")
            })
            .catch { error -> AnyPublisher<[PerfumeItem], Error> in
                print("Failed to load OOTD perfumes: \(error.localizedDescription)")
                return Just([PerfumeItem]())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - OOTD 상세 조회
    
    func getOOTDDetail(ootdId: Int) -> AnyPublisher<OOTDDetailData, Error> {
        return networkService
            .request(.getOOTDDetails(ootdId: ootdId),
                    responseType: OOTDDetailResponse.self)
            .map { response in
                return response.data ?? self.createEmptyDetailData()
            }
            .handleEvents(receiveOutput: { detailData in
                print("Successfully loaded OOTD detail for ID: \(detailData.ootdInfo.ootdId)")
            })
            .catch { error -> AnyPublisher<OOTDDetailData, Error> in
                print("Failed to load OOTD detail: \(error.localizedDescription)")
                return Just(self.createEmptyDetailData())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    private func createEmptyDetailData() -> OOTDDetailData {
        return OOTDDetailData(
            ootdInfo:
                OOTDInfo(
                    ootdId: 0,
                    createdAt: Date(),
                    ootdImageUrls: [],
                    likeCount: 0,
                    commentCount: 0,
                    volume: 0,
                    content: "",
                    tags: [],
                    isLiked: false
                ),
            userInfo: UserInfo(
                gender: "",
                age: 0
            ),
            perfumeInfo: []
        )
    }
}
