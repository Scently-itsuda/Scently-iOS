//
//  AuthService.swift
//  Scently
//
//  Created by 임재현 on 11/11/25.
//

import Foundation

protocol AuthServiceProtocol {
    func hasValidToken() -> Bool
    func saveToken(_ token: String)
    func clearToken()
    func getToken() -> String?
    func checkUserRegistration(token: String, completion: @escaping (Result<Bool, Error>) -> Void)
}

class AuthService: AuthServiceProtocol {
    private let tokenKey = "userToken"
    
    init() {}
    
    func hasValidToken() -> Bool {
        UserDefaults.standard.string(forKey: tokenKey) != nil
    }
    
    func saveToken(_ token: String) {
        UserDefaults.standard.set(token, forKey: tokenKey)
    }
    
    func clearToken() {
        UserDefaults.standard.removeObject(forKey: tokenKey)
    }
    
    func getToken() -> String? {
        UserDefaults.standard.string(forKey: tokenKey)
    }
    
    func checkUserRegistration(token: String, completion: @escaping (Result<Bool,Error>) -> Void) {
        DispatchQueue.main.asyncAfter(deadline:.now() + 1.0) {
            let isRegisterd = !token.contains("new_")
            completion(.success(isRegisterd))
        }
    }
}
