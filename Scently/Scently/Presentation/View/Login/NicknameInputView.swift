//
//  NicknameInputView.swift
//  Scently
//
//  Created by 임재현 on 6/19/25.
//

import UIKit
import SnapKit

final class NicknameInputView: UIView {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.lightGray.cgColor
        view.layer.cornerRadius = 8
        return view
    }()
    
    private let nicknameTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "닉네임 입력"
        textField.font = .pretendard(.regular, size: 16)
        textField.borderStyle = .none
        textField.returnKeyType = .done
        return textField
    }()
    
    private let duplicateCheckButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("중복확인", for: .normal)
        button.titleLabel?.font = .pretendard(.medium, size: 12)
        button.setTitleColor(.gray3, for: .normal)
        button.backgroundColor = .gray4
        button.layer.cornerRadius = 8
        return button
    }()
    
    private let errorLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .systemRed
        label.isHidden = true
        return label
    }()
    
    private let loadingIndicator: UIActivityIndicatorView = {
        let indicator = UIActivityIndicatorView(style: .medium)
        indicator.hidesWhenStopped = true
        indicator.color = .gray
        return indicator
    }()
    
    var onDuplicateCheck: ((String) -> Void)?
    var onTextChanged: ((String) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupActions()
        setupTextField()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubviews(containerView, errorLabel)
        containerView.addSubviews(nicknameTextField, duplicateCheckButton,loadingIndicator)
    }
    
    private func setupLayout() {
        containerView.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
            $0.height.equalTo(52) // 컨테이너 자체를 52로 유지
        }
        
        nicknameTextField.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.trailing.equalTo(duplicateCheckButton.snp.leading).offset(-8)
        }
        
        duplicateCheckButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(32)
        }
        
        loadingIndicator.snp.makeConstraints {
            $0.center.equalTo(duplicateCheckButton)
        }
        
        errorLabel.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.bottom).offset(4)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            $0.height.greaterThanOrEqualTo(16)
        }
    }
    
    private func setupActions() {
        nicknameTextField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        duplicateCheckButton.addTarget(self, action: #selector(duplicateCheckTapped), for: .touchUpInside)
    }
    
    private func setupTextField() {
        nicknameTextField.delegate = self
    }
    
    @objc private func textFieldDidChange() {
        let text = nicknameTextField.text ?? ""
        onTextChanged?(text)
        hideError()
    }
    
    @objc private func duplicateCheckTapped() {
        let nickname = nicknameTextField.text ?? ""
        guard !nickname.isEmpty else {
            showError("닉네임을 입력해주세요")
            return
        }
        
        onDuplicateCheck?(nickname)
    }
}

extension NicknameInputView {
    
    func showLoading() {
        duplicateCheckButton.isHidden = true
        loadingIndicator.startAnimating()
    }
    
    func hideLoading() {
        loadingIndicator.stopAnimating()
        duplicateCheckButton.isHidden = false
    }
    
    func showError(_ message: String) {
        hideLoading()
        errorLabel.text = message
        errorLabel.textColor = .systemRed
        errorLabel.isHidden = false
        
        containerView.layer.borderColor = UIColor.systemRed.cgColor
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func hideError() {
        errorLabel.isHidden = true
        containerView.layer.borderColor = UIColor.lightGray.cgColor
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func showSuccess(_ message: String) {
        hideLoading()
        hideError()
        containerView.layer.borderColor = UIColor.systemGreen.cgColor
        
        errorLabel.text = message
        errorLabel.textColor = .systemGreen
        errorLabel.isHidden = false
        
        UIView.animate(withDuration: 0.3) {
            self.layoutIfNeeded()
        }
    }
    
    func getNickname() -> String {
        return nicknameTextField.text ?? ""
    }
    
    func setNickname(_ nickname: String) {
        nicknameTextField.text = nickname
    }
    
    func setDuplicateCheckEnabled(_ enabled: Bool) {
        duplicateCheckButton.isEnabled = enabled
        duplicateCheckButton.alpha = enabled ? 1.0 : 0.6
    }
}

extension NicknameInputView: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()  // 키보드 내리기
        return true
    }
}

extension NicknameInputView {

    func highlightDuplicateCheckButton(_ shouldHighlight: Bool) {
        UIView.animate(withDuration: 0.3) {
            if shouldHighlight {
                // 강조 상태 - 파란색으로 변경
                self.duplicateCheckButton.backgroundColor = .systemBlue
                self.duplicateCheckButton.setTitleColor(.white, for: .normal)
                
                // 살짝 커지는 효과
                self.duplicateCheckButton.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
                
            } else {
                // 기본 상태로 복귀
                self.duplicateCheckButton.backgroundColor = .gray4
                self.duplicateCheckButton.setTitleColor(.gray3, for: .normal)
                self.duplicateCheckButton.transform = .identity
            }
        }
    }
}
