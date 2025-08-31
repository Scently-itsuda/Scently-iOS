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
    func deleteOOTD(ootdId: Int) -> AnyPublisher<Bool, Error>
    func likeOOTD(ootdId: Int) -> AnyPublisher<Bool, Error>
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
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data ?? OOTDListData(dataList: [], pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0))
            }
            .handleEvents(receiveOutput: { ootdListData in
                print("Successfully loaded \(ootdListData.dataList.count) OOTDs")
            })
            .catch { error -> AnyPublisher<OOTDListData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load OOTD list: \(networkError.errorDescription ?? "")")
                } else {
                    print("Failed to load OOTD list: \(error.localizedDescription)")
                }
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
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data?.ootdId ?? 0
            }
            .handleEvents(receiveOutput: { ootdId in
                print("Successfully created OOTD with ID: \(ootdId)")
            })
            .catch { error -> AnyPublisher<Int, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to create OOTD: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .invalidToken, .expiredToken:
                        // 토큰 관련 에러 - 로그인 화면으로 이동 등
                        break
                    case .internalServerError:
                        // 서버 에러 - 재시도 유도
                        break
                    default:
                        break
                    }
                } else {
                    print("Failed to create OOTD: \(error.localizedDescription)")
                }
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
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data?.perfumes ?? []
            }
            .handleEvents(receiveOutput: { perfumes in
                print("Successfully loaded \(perfumes.count) perfumes for OOTD")
            })
            .catch { error -> AnyPublisher<[PerfumeItem], Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load OOTD perfumes: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .invalidToken, .expiredToken:
                        // 토큰 관련 에러 처리
                        break
                    case .internalServerError:
                        // 서버 에러 처리
                        break
                    default:
                        break
                    }
                } else {
                    print("Failed to load OOTD perfumes: \(error.localizedDescription)")
                }
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
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data ?? self.createEmptyDetailData()
            }
            .handleEvents(receiveOutput: { detailData in
                print("Successfully loaded OOTD detail for ID: \(detailData.ootdInfo.ootdId)")
            })
            .catch { error -> AnyPublisher<OOTDDetailData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load OOTD detail: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .ootdNotFound, .ootdAlreadyDeleted:
                        // OOTD를 찾을 수 없는 경우 - 이전 화면으로 이동
                        break
                    case .invalidToken, .expiredToken:
                        // 토큰 관련 에러 처리
                        break
                    case .internalServerError:
                        // 서버 에러 처리
                        break
                    default:
                        break
                    }
                } else {
                    print("Failed to load OOTD detail: \(error.localizedDescription)")
                }
                return Just(self.createEmptyDetailData())
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - OOTD 삭제
    
    func deleteOOTD(ootdId: Int) -> AnyPublisher<Bool, Error> {
        return networkService
            .request(.deleteOOTD(ootdId: ootdId),
                    responseType: DeleteOOTDResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return true
            }
            .catch { error -> AnyPublisher<Bool, Error> in
                if let networkError = error as? NetworkError {
                    print("Delete failed: \(networkError.errorDescription ?? "")")
                }
                return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - OOTD 좋아요
    
    func likeOOTD(ootdId: Int) -> AnyPublisher<Bool, Error> {
        return networkService
            .request(.likeOOTD(ootdId: ootdId),
                    responseType: LikeOOTDResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return true
            }
            .catch { error -> AnyPublisher<Bool, Error> in
                if let networkError = error as? NetworkError {
                    print("Delete failed: \(networkError.errorDescription ?? "")")
                }
                return Just(false).setFailureType(to: Error.self).eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    //MARK: - OOTD 상세 댓글 조회
    
    func getOOTDDetailComments(ootdId: Int) -> AnyPublisher<CommentData, Error> {
        return networkService
            .request(.getOOTDDetailComments(ootdId: ootdId),
                    responseType: OOTDCommentResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response.data ?? CommentData.empty()
            }
            .handleEvents(receiveOutput: { commentData in
                print("Successfully loaded \(commentData.totalCommentCount) comments")
            })
            .catch { error -> AnyPublisher<CommentData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load comments: \(networkError.errorDescription ?? "")")
                }
                return Just(CommentData.empty())
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
