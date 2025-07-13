//
//  AppConfig.swift
//  Scently
//
//  Created by 임재현 on 7/13/25.
//

import Foundation

struct AppConfig {
    static let shared = AppConfig()
    
    private init() {}
    
     var baseURL: String = {
        guard let url = Bundle.main.infoDictionary?["BASE_URL"] as? String else {
            fatalError("API_BASE_URL is missing in Info.plist")
        }
        return url
    }()
    
     var apiVersion: String = "/v1"
    

    
     var kakaoAppKey: String = {
        guard let key = Bundle.main.infoDictionary?["KAKAO_NATIVE_APPKEY"] as? String else {
            fatalError("Kakao App Key is missing in Info.plist")
        }
        return key
    }()
    
    
     var kakaoAPIKey: String = {
        guard let key = Bundle.main.infoDictionary?["KAKAO_API_KEY"] as? String else {
            fatalError("Kakao API Key is missing in Info.plist")
        }
        return key
    }()
    
    //ToDo: - 구글, 애플 등 API Key 추가 예정
    

    var networkTimeout: TimeInterval { return 30.0 }
    var maxRetryCount: Int { return 3 }
    
    
    var isDebug: Bool {
        #if DEBUG
        return true
        #else
        return false
        #endif
    }
}
