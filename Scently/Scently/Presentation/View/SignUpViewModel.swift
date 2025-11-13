//
//  SignUpViewModel.swift
//  Scently
//
//  Created by 임재현 on 11/13/25.
//

import UIKit
import Combine

final class SignupViewModel {
    
    private let authService: AuthServiceProtocol
    
    @Published var selectedGender: Gender?
    @Published var birthDate: Date?
    @Published var isBirthDatePrivate: Bool = false
    @Published var nickname: String = ""
    
    @Published var nicknameValidationState: NicknameValidationState = .empty
    
    
    @Published var isFormValid: Bool = false
    @Published var canCheckDuplicate: Bool = false
    @Published var shouldHilightedDuplicatedCheck: Bool = false
    
    private var cancellable = Set<AnyCancellable>()
    
    init(authService: AuthServiceProtocol) {
        self.authService = authService
        setupBindings()
    }
}

extension SignupViewModel {
    
    private func setupBindings() {
        
        $nickname
            .debounce(for: 0.3, scheduler: DispatchQueue.main)
            .map { [weak self] text in
                self?.validateNicknameFormat(text) ?? .empty
            }
            .sink { [weak self] state in
                self?.nicknameValidationState = state
            }
            .store(in: &cancellable)
        
        $nicknameValidationState
            .map { state in
                if case .validButNotChecked = state {
                    return true
                }
                
                return false
            }
            .assign(to: &$canCheckDuplicate)
        
        $nicknameValidationState
            .map { state in
                if case .validButNotChecked = state {
                    return true
                }
                return false
            }
            .assign(to: &$shouldHilightedDuplicatedCheck)
        
        Publishers.CombineLatest4(
            $selectedGender,
            $birthDate,
            $isBirthDatePrivate,
            $nicknameValidationState
        )
        .map { gender, date, isPrivate, nicknameState  in
            let genderValid = gender != nil // 성별선택완료
            let birthDateValid = date != nil || isPrivate // 생년월일 입력 or 비공개
            
            let nicknameValid: Bool
            
            if case .available = nicknameState {
                nicknameValid = true
            } else {
                nicknameValid = false
            }
            
            return genderValid && birthDateValid && nicknameValid
        }
        .assign(to: &$isFormValid)
        
    }
    
    func canSubmit() -> (canSubmit: Bool, errorMessage: String?) {
        if nickname.isEmpty {
            return (false, "닉네임을 입력해주세요")
        }
        
        if case .available = nicknameValidationState {
           
        } else {
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
    
    private func validateNicknameFormat(_ text: String) -> NicknameValidationState {
        if text.isEmpty {
            return .empty
        }
        
        if text.count < 2 {
            return .invalid(reason: "닉네임은 2글자 이상이여야 합니다")
        }
        
        if text.count < 10 {
            return .invalid(reason: "닉네임은 10글자 이하로 입력해주세요")
        }
        
        let allowedCharacters = CharacterSet.alphanumerics
            .union(CharacterSet(charactersIn: "가-힣"))
        
        if text.rangeOfCharacter(from: allowedCharacters.inverted) != nil {
            return .invalid(reason: "한글, 영문, 숫자만 입력 가능해요")
        }
        
        return .validButNotChecked
    }
    
    func checkNicknameDuplicate() {
        
    }
}
