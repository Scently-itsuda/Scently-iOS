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
}
