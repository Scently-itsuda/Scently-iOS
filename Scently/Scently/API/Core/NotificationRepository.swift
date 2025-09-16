//
//  NotificationRepository.swift
//  Scently
//
//  Created by 임재현 on 9/17/25.
//

import Foundation
import Combine

protocol NotificationRepositoryProtocol {
    func getNotifications(
         page: Int,
         size: Int
     ) -> AnyPublisher<NotificationData, Error>
    
    func registerFCMToken(
        fcmToken: String
    ) -> AnyPublisher<FCMTokenData, Error>
}

class NotificationRepository: NotificationRepositoryProtocol {
    private let networkService: NetworkService<NotificationTarget>
    
    init(networkService: NetworkService<NotificationTarget> = NetworkService<NotificationTarget>()) {
        self.networkService = networkService
    }
    
    func getNotifications(
        page: Int,
        size: Int
    ) -> AnyPublisher<NotificationData, Error> {
        return networkService.request(
            .getNotifications(page: page, size: size),
            responseType: NotificationResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? NotificationData(
                dataList: [],
                pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)
            )
        }
        .handleEvents(receiveOutput: { notificationData in
            print("Successfully loaded \(notificationData.dataList.count) notifications")
        })
        .catch { error -> AnyPublisher<NotificationData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to load notifications: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to load notifications: \(error.localizedDescription)")
            }
            return Just(NotificationData(
                dataList: [],
                pageInfo: PageInfo(page: 0, size: 0, totalElements: 0, totalPages: 0)
            ))
            .setFailureType(to: Error.self)
            .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    func registerFCMToken(
        fcmToken: String
    ) -> AnyPublisher<FCMTokenData, Error> {
        return networkService.request(
            .registerFCMToken(fcmToken: fcmToken),
            responseType: FCMTokenResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? FCMTokenData(isSaved: false)
        }
        .handleEvents(receiveOutput: { fcmTokenData in
            print("FCM Token registration result: \(fcmTokenData.isSaved)")
        })
        .catch { error -> AnyPublisher<FCMTokenData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to register FCM token: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to register FCM token: \(error.localizedDescription)")
            }
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
