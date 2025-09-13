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
    
    func postFreeBoard(title: String, content: String, tagNames: [String]) -> AnyPublisher<CreatedPostData, Error>
    
    func getDetailFreeBoard(postID: Int) -> AnyPublisher<FreeBoardDetailData, Error>
    
    func deleteFreeBoard(postId: Int) -> AnyPublisher<DeleteFreeBoardResponse, Error>
    func likeFreeBoard(postId: Int) -> AnyPublisher<LikeFreeBoardResponse, Error>
    func getFreeBoardComments(postId: Int) -> AnyPublisher<FreeBoardCommentsData, Error>
    func postFreeBoardComment(postId: Int, commentId:Int?, comment: String)  -> AnyPublisher<FreeBoardCommentData, Error>
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
    
    func postFreeBoard(title: String, content: String, tagNames: [String]) -> AnyPublisher<CreatedPostData, any Error> {
        return networkService.request(.postFreeBoard(title: title, content: content, tagNames: tagNames), responseType: CreatePostResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                guard let data = response.data else {
                    throw NetworkError.unknownError
                }
                return data
            }
            .handleEvents(receiveOutput: { createdPost in
                print("Successfully created post with ID: \(createdPost)")
            })
            .catch { error -> AnyPublisher<CreatedPostData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to create post: \(networkError.errorDescription ?? "")")
                    
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
                    print("Failed to create post: \(error.localizedDescription)")
                }
                return Just(CreatedPostData(postId: 0))
                    .setFailureType(to: Error.self)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getDetailFreeBoard(postID: Int) -> AnyPublisher<FreeBoardDetailData, Error> {
       return networkService.request(.getDetailFreeBoard(postID: postID), responseType: FreeBoardDetailResponse.self)
           .tryMap { response in
               if !response.success {
                   throw response.networkError ?? NetworkError.unknownError
               }
               guard let data = response.data else {
                   throw NetworkError.unknownError
               }
               return data
           }
           .handleEvents(receiveOutput: { detailData in
               print("Successfully loaded post detail: \(detailData.postInfo.title)")
           })
           .catch { error -> AnyPublisher<FreeBoardDetailData, Error> in
               if let networkError = error as? NetworkError {
                   print("Failed to load post detail: \(networkError.errorDescription ?? "")")
                   
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
                   print("Failed to load post detail: \(error.localizedDescription)")
               }
               
               return Fail(error: error)
                   .eraseToAnyPublisher()
           }
           .eraseToAnyPublisher()
    }
    
    func deleteFreeBoard(postId: Int) -> AnyPublisher<DeleteFreeBoardResponse, any Error> {
        return networkService.request(.deleteFreeBoard(postId: postId), responseType: DeleteFreeBoardResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response
            }
            .handleEvents(receiveOutput: { response in
                print("Successfully deleted post with ID: \(postId)")
                print("Server message: \(response.message)")
            })
            .catch { error -> AnyPublisher<DeleteFreeBoardResponse, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to delete post: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .onlyAuthorCanDelete:
                        print("Only author can delete this post")
                    case .ootdNotFound, .ootdAlreadyDeleted:
                        print("Post not found or already deleted")
                    case .invalidToken, .expiredToken:
                        print("Token error - need to re-login")
                    case .internalServerError:
                        print("Server error - please try again later")
                    default:
                        break
                    }
                } else {
                    print("Failed to delete post: \(error.localizedDescription)")
                }
    
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func likeFreeBoard(postId: Int) -> AnyPublisher<LikeFreeBoardResponse, any Error> {
        return networkService.request(.deleteFreeBoard(postId: postId), responseType: LikeFreeBoardResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                return response
            }
            .handleEvents(receiveOutput: { response in
                print("Successfully deleted post with ID: \(postId)")
                print("Server message: \(response.message)")
            })
            .catch { error -> AnyPublisher<DeleteFreeBoardResponse, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to delete post: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .onlyAuthorCanDelete:
                        print("Only author can delete this post")
                    case .ootdNotFound, .ootdAlreadyDeleted:
                        print("Post not found or already deleted")
                    case .invalidToken, .expiredToken:
                        print("Token error - need to re-login")
                    case .internalServerError:
                        print("Server error - please try again later")
                    default:
                        break
                    }
                } else {
                    print("Failed to delete post: \(error.localizedDescription)")
                }
    
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    func getFreeBoardComments(postId: Int) -> AnyPublisher<FreeBoardCommentsData, any Error> {
        return networkService.request(.getFreeBoardComments(postId: postId), responseType: FreeBoardCommentsResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                guard let data = response.data else {
                    throw NetworkError.unknownError
                }
                return data
            }
            .handleEvents(receiveOutput: { commentsData in
                print("Successfully loaded \(commentsData.totalCommentCount) total comments")
                print("Parent comments: \(commentsData.commentInfos.count)")
            })
            .catch { error -> AnyPublisher<FreeBoardCommentsData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to load comments: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .ootdNotFound:
                        print("Post not found")
                    case .invalidToken, .expiredToken:
                        print("Token error - need to re-login")
                    case .internalServerError:
                        print("Server error - please try again later")
                    default:
                        break
                    }
                } else {
                    print("Failed to load comments: \(error.localizedDescription)")
                }
        
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
    
    
    func postFreeBoardComment(postId: Int, commentId: Int?, comment: String) -> AnyPublisher<FreeBoardCommentData, any Error> {
        return networkService.request(.postFreeBoardComment(postId: postId, commentId: commentId, comment: comment), responseType: PostFreeBoardCommentResponse.self)
            .tryMap { response in
                if !response.success {
                    throw response.networkError ?? NetworkError.unknownError
                }
                guard let data = response.data else {
                    throw NetworkError.unknownError
                }
                return data
            }
            .handleEvents(receiveOutput: { commentData in
                if let commentId = commentId {
                    print("Successfully created reply comment for parent ID: \(commentId)")
                } else {
                    print("Successfully created new comment for post ID: \(postId)")
                }
                print("Created comment ID: \(commentData.commentId)")
            })
            .catch { error -> AnyPublisher<FreeBoardCommentData, Error> in
                if let networkError = error as? NetworkError {
                    print("Failed to create comment: \(networkError.errorDescription ?? "")")
                    
                    switch networkError {
                    case .ootdNotFound:
                        print("Post not found")
                    case .invalidToken, .expiredToken:
                        print("Token error - need to re-login")
                    case .internalServerError:
                        print("Server error - please try again later")
                    default:
                        break
                    }
                } else {
                    print("Failed to create comment: \(error.localizedDescription)")
                }
                
                return Fail(error: error)
                    .eraseToAnyPublisher()
            }
            .eraseToAnyPublisher()
    }
}
