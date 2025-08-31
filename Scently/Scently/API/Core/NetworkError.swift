//
//  NetworkError.swift
//  Scently
//
//  Created by 임재현 on 6/18/25.
//

import Foundation

enum NetworkError: Int, Error, CustomStringConvertible {
    var description: String { self.errorDescription ?? "알 수 없는 오류가 발생했습니다."}
    case invalidURL
    case requestEncodingError
    case responseDecodingError
    case responseError
    case unknownError
    
    case onlyAuthorCanDelete
    
    case accessDeniedToken
    case invalidToken
    case expiredToken
    case tokenTypeError
    case unsupportedToken
    case unknownTokenError
    case invalidTokenFormat
    
    case userNotFound
    case ootdNotFound
    case ootdAlreadyDeleted

    case internalServerError

    var errorDescription: String? {
         switch self {
         // 클라이언트 에러
         case .invalidURL:
             return "잘못된 URL입니다."
         case .requestEncodingError:
             return "요청 인코딩에 실패했습니다."
         case .responseDecodingError:
             return "응답 디코딩에 실패했습니다."
         case .responseError:
             return "응답 오류가 발생했습니다."
         case .unknownError:
             return "알 수 없는 오류가 발생했습니다."
             
         // 서버 에러 (1400번대)
         case .onlyAuthorCanDelete:
             return "OOTD 작성자만 OOTD 게시글을 삭제할 수 있습니다."
             
         // 서버 에러 (1401번대 - 토큰 관련)
         case .accessDeniedToken:
             return "접근이 거부된 토큰입니다."
         case .invalidToken:
             return "유효하지 않은 토큰입니다."
         case .expiredToken:
             return "만료된 토큰입니다."
         case .tokenTypeError:
             return "토큰 타입 오류입니다."
         case .unsupportedToken:
             return "지원하지 않는 토큰입니다."
         case .unknownTokenError:
             return "알 수 없는 토큰 오류입니다."
         case .invalidTokenFormat:
             return "토큰 형식이 올바르지 않습니다."
             
         // 서버 에러 (1404번대)
         case .userNotFound:
             return "존재하지 않는 사용자입니다."
         case .ootdNotFound:
             return "존재하지 않는 OOTD 게시글입니다."
         case .ootdAlreadyDeleted:
             return "이미 삭제된 OOTD 게시글입니다."
             
         // 서버 에러 (1500번대)
         case .internalServerError:
             return "서버 내부 오류가 발생했습니다."
         }
     }
    
    var code: Int {
        switch self {
        case .onlyAuthorCanDelete:
            return 1400
        case .accessDeniedToken, .invalidToken, .expiredToken, .tokenTypeError, .unsupportedToken, .unknownTokenError, .invalidTokenFormat:
            return 1401
        case .userNotFound, .ootdNotFound, .ootdAlreadyDeleted:
            return 1404
        case .internalServerError:
            return 1500
        default:
            return 0
        }
    }
    
    // 토큰 관련 에러인지 확인
    var isTokenError: Bool {
        return code == 1401
    }
    
    // 권한 관련 에러인지 확인
    var isAuthorizationError: Bool {
        return code == 1400 || code == 1401
    }
}

extension NetworkError {
    // 서버 에러 코드와 메시지로 NetworkError 생성
    static func from(code: String?, message: String?) -> NetworkError {
        guard let codeString = code, let errorCode = Int(codeString) else {
            return .unknownError
        }
        
        switch errorCode {
        case 1400:
            return .onlyAuthorCanDelete
            
        case 1401:
            // 메시지로 세부 구분
            if let msg = message {
                if msg.contains("접근이 거부") { return .accessDeniedToken }
                if msg.contains("만료") { return .expiredToken }
                if msg.contains("타입 오류") { return .tokenTypeError }
                if msg.contains("지원하지 않는") { return .unsupportedToken }
                if msg.contains("형식") { return .invalidTokenFormat }
                if msg.contains("알 수 없는") { return .unknownTokenError }
            }
            return .invalidToken
            
        case 1404:
            if let msg = message {
                if msg.contains("사용자") { return .userNotFound }
                if msg.contains("이미 삭제") { return .ootdAlreadyDeleted }
                if msg.contains("OOTD") { return .ootdNotFound }
            }
            return .ootdNotFound
            
        case 1500:
            return .internalServerError
            
        default:
            return .unknownError
        }
    }
}
