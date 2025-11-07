//
//  SocialLoginType.swift
//  Scently
//
//  Created by 임재현 on 6/19/25.
//

import Foundation

enum SocialLoginType: CaseIterable {
    case kakao, google, apple, naver, none
    
    var imageName: String {
        switch self {
        case .kakao: return "kakaoButton"
        case .google: return "NaverButton"
        case .apple: return "GoogleButton"
        case .naver: return "AppleButton"
        case .none: return "NoneButton"
        }
    }
}
