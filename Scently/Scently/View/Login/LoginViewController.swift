//
//  LoginViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit
import SnapKit

final class LoginViewController: UIViewController {
    
    private let logoLabel: UILabel = {
        let label = UILabel()
        label.text = "SCENTLY"
        label.font = .pretendard(.bold, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "당신과 취향을 공유해요."
        label.font = .pretendard(.bold, size: 30)
        label.textColor = .black
        return label
    }()
    
    private let socialLoginStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.spacing = 16
        return stackView
    }()
    
    private var socialLoginButtons: [SocialLoginType: UIButton] = [:]
    
    private let inquiryButton: UIButton = {
        let button = UIButton()
        button.setTitle("문의하기", for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 12)
        button.setTitleColor(.gray3, for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setUI()
        setupLayout()
        setupButtons()
    }
    
    private func setUI() {
        self.view.addSubviews(
            logoLabel,
            subTitleLabel,
            socialLoginStackView,
            inquiryButton
        )
    }
    
    private func setupLayout() {
        logoLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(80)
            $0.leading.equalToSuperview().offset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(logoLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        
        inquiryButton.snp.makeConstraints {
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.centerX.equalToSuperview()
        }
        
        socialLoginStackView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(inquiryButton.snp.top).offset(-12)
            $0.top.greaterThanOrEqualTo(subTitleLabel.snp.bottom).offset(20)
        }
           
      
        socialLoginButtons.values.forEach { button in
            button.snp.makeConstraints {
                $0.height.equalTo(52)
            }
        }
        
      
    }
    
    private func setupButtons() {
        SocialLoginType.allCases.forEach { type in
            let button = createSocialLoginButton(for: type)
            socialLoginButtons[type] = button
            socialLoginStackView.addArrangedSubview(button)
        }
    
    }
    
    private func createSocialLoginButton(for type: SocialLoginType) -> UIButton {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: type.imageName), for: .normal)
        button.layer.cornerRadius = 8
        button.imageView?.contentMode = .scaleAspectFit
        button.addTarget(self, action: #selector(socialLoginButtonTapped(_:)), for: .touchUpInside)
        button.tag = SocialLoginType.allCases.firstIndex(of: type) ?? 0
        button.adjustsImageWhenHighlighted = false
            
        return button
    }
    
    @objc private func socialLoginButtonTapped(_ sender: UIButton) {
        let type = SocialLoginType.allCases[sender.tag]
        handleSocialLogin(type: type)
    }
    
    private func handleSocialLogin(type: SocialLoginType) {
            switch type {
            case .kakao:
                print("카카오 로그인 버튼 탭됨")
            case .google:
                print("구글 로그인 버튼 탭됨")
            case .apple:
                print("애플 로그인 버튼 탭됨")
            case .naver:
                print("네이버 로그인 버튼 탭됨")
            case .none:
                print("나중에 로그인 버튼 탭됨")
            }
        }
    
}

