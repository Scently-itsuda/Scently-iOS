//
//  ReportRepository.swift
//  Scently
//
//  Created by 임재현 on 9/16/25.
//

import Foundation
import Combine

protocol ReportRepositoryProtocol {
    func reportOOTD(ootdId: String,reportType: String,otherReason: String?) -> AnyPublisher<ReportData, Error>
    func reportFreeBoard(postId: String, reportType: String, otherReason: String?) -> AnyPublisher<ReportData, Error>
    func reportCommentBoard(commentId: String, reportType: String, otherReason: String?) -> AnyPublisher<ReportData, Error>
}


class ReportRepository: ReportRepositoryProtocol {
    
    private let networkService: NetworkService<ReportTarget>
    
    init(networkService: NetworkService<ReportTarget> = NetworkService<ReportTarget>()) {
        self.networkService = networkService
    }
    
    func reportOOTD(ootdId: String,reportType: String,otherReason: String?) -> AnyPublisher<ReportData, Error> {
        return networkService.request(
            .reportOOTD(
                ootdId: ootdId,
                reportType: reportType,
                otherReason: otherReason
            ),
            responseType: ReportOOTDResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? ReportData(reportId: 0)
        }
        .handleEvents(receiveOutput: { reportData in
            print("Successfully reported OOTD with report ID: \(reportData.reportId)")
        })
        .catch { error -> AnyPublisher<ReportData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to report OOTD: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to report OOTD: \(error.localizedDescription)")
            }
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    func reportFreeBoard(postId: String, reportType: String, otherReason: String?) -> AnyPublisher<ReportData, Error> {
        return networkService.request(
            .reportFreeBoard(
                postId: postId,
                reportType: reportType,
                otherReason: otherReason
            ),
            responseType: ReportFreeBoardResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? ReportData(reportId: 0)
        }
        .handleEvents(receiveOutput: { reportData in
            print("Successfully reported OOTD with report ID: \(reportData.reportId)")
        })
        .catch { error -> AnyPublisher<ReportData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to report OOTD: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to report OOTD: \(error.localizedDescription)")
            }
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
    
    func reportCommentBoard(commentId: String, reportType: String, otherReason: String?) -> AnyPublisher<ReportData, Error> {
        return networkService.request(
            .reportComment(
                commentId: commentId,
                reportType: reportType,
                otherReason: otherReason
            ),
            responseType: ReportCommentResponse.self
        )
        .tryMap { response in
            if !response.success {
                throw response.networkError ?? NetworkError.unknownError
            }
            return response.data ?? ReportData(reportId: 0)
        }
        .handleEvents(receiveOutput: { reportData in
            print("Successfully reported OOTD with report ID: \(reportData.reportId)")
        })
        .catch { error -> AnyPublisher<ReportData, Error> in
            if let networkError = error as? NetworkError {
                print("Failed to report OOTD: \(networkError.errorDescription ?? "")")
            } else {
                print("Failed to report OOTD: \(error.localizedDescription)")
            }
            return Fail(error: error)
                .eraseToAnyPublisher()
        }
        .eraseToAnyPublisher()
    }
}
