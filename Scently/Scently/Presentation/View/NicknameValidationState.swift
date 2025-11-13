//
//  NicknameValidationState.swift
//  Scently
//
//  Created by 임재현 on 11/13/25.
//

import Foundation

enum NicknameValidationState: Equatable {
    case empty // 입력 x
    case invalid(reason: String) // 1차 유효성 검사 실패
    case validButNotChecked // 1차 유효성 검사 통과, 중복확인 x
    case checking // 중복확인 체크
    case available // 사용 가능(1차 유효성, 중복확인 통과)
    case duplicate // 중복됨
    case error(message: String) // 네트워크 등의 오류
    
    
    static func == (lhs: NicknameValidationState, rhs: NicknameValidationState) -> Bool {
        switch (lhs,rhs) {
        case (.empty, .empty),
             (.validButNotChecked, .validButNotChecked),
             (.checking, .checking),
             (.available, .available),
             (.duplicate, .duplicate):
                 return true
        case (.invalid(let lReason), .invalid(let rReason)):
            return lReason == rReason
        case (.error(let lMsg), .error(let rMsg)):
            return lMsg == rMsg
        default:
            return false
        }
    }
}
