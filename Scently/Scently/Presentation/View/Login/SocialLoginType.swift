//
//  SocialLoginType.swift
//  Scently
//
//  Created by 임재현 on 6/19/25.
//

import Foundation

enum SocialLoginType: CaseIterable {
    case kakao,apple,none
    
    var imageName: String {
        switch self {
        case .kakao: return "kakaoButton"
        case .apple: return "AppleButton"
        case .none: return "NoneButton"
        }
    }
}
