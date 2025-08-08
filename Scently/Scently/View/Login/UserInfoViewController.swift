//
//  UserInfoViewController.swift
//  Scently
//
//  Created by 임재현 on 6/19/25.
//

import UIKit
import SnapKit

final class UserInfoViewController: UIViewController {
    
    private var genderButtons: [OptionButton] = []
    private var selectedGender: Gender? = nil
    private let orderedGenders: [Gender] = [.male, .female, .all]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "거의 다 왔어요 !"
        label.font = .pretendard(.bold, size: 18)
        label.textColor = .black
        return label
    }()
    
    private let subTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "간단한 정보만 입력해 주세요:)"
        label.font = .pretendard(.bold, size: 28)
        label.textColor = .black
        return label
    }()
    
    private let genderLabel: UILabel = {
        let label = UILabel()
        label.text = "성별"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let genderStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillEqually
        stackView.spacing = 8
        return stackView
    }()
    
    private let birthDayLabel: UILabel = {
        let label = UILabel()
        label.text = "생년월일"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let nicknameLabel: UILabel = {
        let label = UILabel()
        label.text = "닉네임"
        label.font = .pretendard(.regular, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let nicknameInputView = NicknameInputView()
    
    private let birthDateInputView = BirthDateInputView()
    
    private let completeButton: UIButton = {
        let button = UIButton()
        button.setTitle("적용하기", for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        createGenderButtons()
        setupNicknameInput()
        setupBirthDateInput()
    }
    
    private func setupUI() {
        self.view.addSubviews(
            titleLabel,
            subTitleLabel,
            genderLabel,
            genderStackView,
            birthDayLabel,
            nicknameLabel,
            nicknameInputView,
            completeButton,
            birthDateInputView
        )
        self.view.backgroundColor = .white
    }
    
    private func setupLayout() {
        titleLabel.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(80)
            $0.leading.equalToSuperview().offset(16)
        }
        
        subTitleLabel.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        
        genderLabel.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel.snp.bottom).offset(52)
            $0.leading.equalTo(subTitleLabel.snp.leading)
        }
        genderStackView.snp.makeConstraints {
            $0.top.equalTo(genderLabel.snp.bottom).offset(8)
            $0.leading.equalTo(genderLabel.snp.leading)
            $0.trailing.equalToSuperview().offset(-16)
            $0.height.equalTo(52)
        }
        birthDayLabel.snp.makeConstraints {
            $0.top.equalTo(genderStackView.snp.bottom).offset(32)
            $0.leading.equalTo(genderStackView.snp.leading)
        }
        birthDateInputView.snp.makeConstraints {
            $0.top.equalTo(birthDayLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        nicknameLabel.snp.makeConstraints {
            $0.top.equalTo(birthDateInputView.snp.bottom).offset(32)
            $0.leading.equalTo(genderStackView.snp.leading)
        }
        
        nicknameInputView.snp.makeConstraints {
            $0.top.equalTo(nicknameLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(52)
        }
    }
    
    private func setupNicknameInput() {

            nicknameInputView.onTextChanged = { [weak self] text in
                print("닉네임 입력: \(text)")
            }
            
            nicknameInputView.onDuplicateCheck = { [weak self] nickname in
                self?.checkNicknameDuplicate(nickname)
            }
        }
    
    private func setupBirthDateInput() {
        
        birthDateInputView.onDateSelected = { [weak self] date in
            if let date = date {
                print("선택된 생년월일: \(date)")
            } else {
                print("생년월일이 초기화됨")
            }
        }
        birthDateInputView.onPrivateToggle = { [weak self] isPrivate in
            print("비공개 상태: \(isPrivate)")
        }
    }
    
    private func createGenderButtons() {
        orderedGenders.enumerated().forEach { index, gender in
            let button = createGenderButton(for: gender)
            button.tag = index
            button.addTarget(self, action: #selector(genderButtonTapped(_:)), for: .touchUpInside)
            
            genderButtons.append(button)
            genderStackView.addArrangedSubview(button)
        }
    }
    
    private func createGenderButton(for gender: Gender) -> OptionButton {
        let button = OptionButton(title: gender.titleForInfo)
        button.configure(font: .pretendard(.bold, size: 16),textColor: .gray3)
        return button
    }
    
    @objc private func genderButtonTapped(_ sender: OptionButton) {
        let tappedGender = orderedGenders[sender.tag]
        
        selectedGender = (selectedGender == tappedGender) ? nil : tappedGender
        updateGenderButtonsUI()
        
        print("선택된 성별: \(selectedGender?.titleForInfo ?? "선택 안함")")
    }
    
    private func updateGenderButtonsUI() {
        orderedGenders.enumerated().forEach { index, gender in
            let button = genderButtons[index]
            let isSelected = selectedGender == gender
            button.updateSelectedState(isSelected: isSelected)
        }
    }
    
    // 네트워크 통신 가정 시뮬레이션 - 추후 데이터 통신으로 바꿀 예정
    private func checkNicknameDuplicate(_ nickname: String) {
        nicknameInputView.setDuplicateCheckEnabled(false)
        
        // 1-3초 랜덤 딜레이로 실제 네트워크 환경 시뮬레이션
        let randomDelay = Double.random(in: 1.0...3.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) { [weak self] in
            self?.nicknameInputView.setDuplicateCheckEnabled(true)
            
            // 랜덤 결과 (70% 성공, 20% 중복, 10% 에러)
            let randomResult = Int.random(in: 1...10)
            
            switch randomResult {
            case 1...7:
                // 70% 확률로 성공
                self?.nicknameInputView.showSuccess()
                print("✅ 사용 가능한 닉네임: \(nickname)")
                
            case 8...9:
                // 20% 확률로 중복
                self?.nicknameInputView.showError("다른 사람이 사용하고 있어요.")
                
            case 10:
                // 10% 확률로 네트워크 에러
                self?.nicknameInputView.showError("네트워크 오류가 발생했습니다.")
                
            default:
                break
            }
        }
    }
    
}
