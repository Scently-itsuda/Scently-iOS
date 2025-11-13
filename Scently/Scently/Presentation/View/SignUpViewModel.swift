//
//  SignUpViewModel.swift
//  Scently
//
//  Created by 임재현 on 11/13/25.
//

import UIKit
import Combine

final class SignupViewModel {
    @Published var selectedGender: Gender?
    @Published var birthDate: Date?
    @Published var isBirthDatePrivate: Bool = false
    @Published var nickname: String = ""
    @Published var isNicknameVerified: Bool = false
    
    @Published var isFormValid: Bool = false
    @Published var shouldHilightedDuplicatedCheck: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init() {
        setupBindings()
    }
}

extension SignupViewModel {
    
    private func setupBindings() {
        Publishers.CombineLatest4(
            $selectedGender,
            $birthDate,
            $isBirthDatePrivate,
            $isNicknameVerified
        )
        .map { gender, date, isPrivate, nicknameVerified  in
            let genderValid = gender != nil // 성별선택완료
            let birthDateValid = date != nil || isPrivate // 생년월일 입력 or 비공개
            let nicknameValid = nicknameVerified // 닉네임 중복확인
            
            return genderValid && birthDateValid && nicknameValid
        }
        .assign(to: &$isFormValid)
        
        Publishers.CombineLatest($nickname , $isNicknameVerified)
            .map { nickname, verified in
                return nickname.count >= 2 && !verified
            }
            .assign(to: &$shouldHilightedDuplicatedCheck)
        
    }
    
    func resetNicknameVerification() {
        isNicknameVerified = false
    }
    
    func completeNicknameVerification() {
        isNicknameVerified = false
    }
    
    func canSubmit() -> (canSubmit: Bool, errorMessage: String?) {
        if nickname.isEmpty {
            return (false, "닉네임을 입력해주세요")
        }
        if !isNicknameVerified {
            return (false, "중복확인을 해주세요")
        }
        
        if selectedGender == nil {
            return (false, "성별을 선택해주세요")
        }
        
        if birthDate == nil && !isBirthDatePrivate {
            return (false, "생년월일을 입력해주세요")
        }
        
        return (true, nil)
    }

}
