//
//  NotificationSettingsViewController.swift
//  Scently
//
//  Created by 임재현 on 8/24/25.
//

import UIKit
import SnapKit

final class NotificationSettingsViewController: UIViewController {
    
    private var profileEditNavigationView = ProfileEditNavigationView()
    
    private let allNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "전체알림"
        label.font = .pretendard(.medium, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let allNotificationToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()
    
    // 이벤트 알림
    private let eventNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "이벤트알림"
        label.font = .pretendard(.medium, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let eventNotificationSubLabel: UILabel = {
        let label = UILabel()
        label.text = "새로운 소식, 신상품 알림"
        label.font = .pretendard(.regular, size: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let eventNotificationToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()
    
    // 소셜 알림
    private let socialNotificationLabel: UILabel = {
        let label = UILabel()
        label.text = "소셜알림"
        label.font = .pretendard(.medium, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let socialNotificationSubLabel: UILabel = {
        let label = UILabel()
        label.text = "좋아요, 댓글, 답글"
        label.font = .pretendard(.regular, size: 14)
        label.textColor = .systemGray
        return label
    }()
    
    private let socialNotificationToggle: UISwitch = {
        let toggle = UISwitch()
        toggle.isOn = true
        return toggle
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
    }
}

extension NotificationSettingsViewController {
    private func setupUI() {
        view.backgroundColor = .white
        view.addSubviews(
            profileEditNavigationView,
            allNotificationLabel,
            allNotificationToggle,
            eventNotificationLabel,
            eventNotificationSubLabel,
            eventNotificationToggle,
            socialNotificationLabel,
            socialNotificationSubLabel,
            socialNotificationToggle
        )
        profileEditNavigationView.configure(title: "알림 설정")
        profileEditNavigationView.delegate = self
        
    }
    
    private func setupConstraints() {
        
        profileEditNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        allNotificationLabel.snp.makeConstraints {
            $0.top.equalTo(profileEditNavigationView.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(16)
        }
        
        allNotificationToggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(allNotificationLabel.snp.centerY)
        }
        
        eventNotificationLabel.snp.makeConstraints {
            $0.top.equalTo(allNotificationLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        eventNotificationSubLabel.snp.makeConstraints {
            $0.top.equalTo(eventNotificationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(eventNotificationLabel.snp.leading)
        }
        
        eventNotificationToggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(eventNotificationLabel.snp.centerY)
        }
        
        socialNotificationLabel.snp.makeConstraints {
            $0.top.equalTo(eventNotificationSubLabel.snp.bottom).offset(40)
            $0.leading.equalToSuperview().offset(16)
        }
        
        socialNotificationSubLabel.snp.makeConstraints {
            $0.top.equalTo(socialNotificationLabel.snp.bottom).offset(4)
            $0.leading.equalTo(socialNotificationLabel.snp.leading)
        }
        
        socialNotificationToggle.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalTo(socialNotificationLabel.snp.centerY)
        }
    }
    
    private func setupActions() {
        allNotificationToggle.addTarget(self, action: #selector(allNotificationToggled), for: .valueChanged)
        eventNotificationToggle.addTarget(self, action: #selector(eventNotificationToggled), for: .valueChanged)
        socialNotificationToggle.addTarget(self, action: #selector(socialNotificationToggled), for: .valueChanged)
    }
    
    @objc private func allNotificationToggled() {
        let isOn = allNotificationToggle.isOn
        
        eventNotificationToggle.isEnabled = isOn
        socialNotificationToggle.isEnabled = isOn
        
        if !isOn {
            eventNotificationToggle.isOn = false
            socialNotificationToggle.isOn = false
        }
        
        updateSubNotificationAppearance()
    }
    
    @objc private func eventNotificationToggled() {
        print("이벤트 알림 토글: \(eventNotificationToggle.isOn)")
    }
    
    @objc private func socialNotificationToggled() {
        print("소셜 알림 토글: \(socialNotificationToggle.isOn)")
    }
    
    private func updateSubNotificationAppearance() {
        let alpha: CGFloat = allNotificationToggle.isOn ? 1.0 : 0.5
        
        eventNotificationLabel.alpha = alpha
        eventNotificationSubLabel.alpha = alpha
        socialNotificationLabel.alpha = alpha
        socialNotificationSubLabel.alpha = alpha
    }
}

extension NotificationSettingsViewController: ProfileEditNavigationViewDelegate {
    func profileEditButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
