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
    
    // 스크롤뷰 추가
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.keyboardDismissMode = .interactive
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        return view
    }()
    
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
        setupKeyboardHandling()
        setupTapGesture()
    }
    
    private func setupUI() {
        self.view.addSubview(scrollView)
        self.view.addSubview(completeButton)
        
        scrollView.addSubview(contentView)
        
        contentView.addSubviews(
            titleLabel,
            subTitleLabel,
            genderLabel,
            genderStackView,
            birthDayLabel,
            nicknameLabel,
            nicknameInputView,
            birthDateInputView
        )
        self.view.backgroundColor = .white
    }
    
    private func setupLayout() {
        scrollView.snp.makeConstraints {
            $0.top.leading.trailing.equalTo(self.view.safeAreaLayoutGuide)
            $0.bottom.equalTo(completeButton.snp.top).offset(-20)
        }
        
        contentView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.width.equalToSuperview()
        }
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(80)
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
            $0.bottom.equalToSuperview().offset(-40) // contentView 하단 여유 공간
        }
        
        completeButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(52)
        }
    }
    
    // 키보드 핸들링 설정
    private func setupKeyboardHandling() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    // 바깥 터치 시 키보드 내리기
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    @objc private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        UIView.animate(withDuration: duration) {
            self.scrollView.contentInset.bottom = keyboardHeight
            self.scrollView.verticalScrollIndicatorInsets.bottom = keyboardHeight
            
            // 현재 활성화된 텍스트필드가 보이도록 스크롤
            if let activeField = self.view.findFirstResponder() {
                let fieldFrame = activeField.convert(activeField.bounds, to: self.scrollView)
                self.scrollView.scrollRectToVisible(fieldFrame, animated: true)
            }
        }
    }
    
    @objc private func keyboardWillHide(_ notification: Notification) {
        guard let duration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        UIView.animate(withDuration: duration) {
            self.scrollView.contentInset.bottom = 0
            self.scrollView.verticalScrollIndicatorInsets.bottom = 0
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
    
    private func checkNicknameDuplicate(_ nickname: String) {
        nicknameInputView.setDuplicateCheckEnabled(false)
        
        let randomDelay = Double.random(in: 1.0...3.0)
        
        DispatchQueue.main.asyncAfter(deadline: .now() + randomDelay) { [weak self] in
            self?.nicknameInputView.setDuplicateCheckEnabled(true)
            
            let randomResult = Int.random(in: 1...10)
            
            switch randomResult {
            case 1...7:
                self?.nicknameInputView.showSuccess()
                print("사용 가능한 닉네임: \(nickname)")
                
            case 8...9:
                self?.nicknameInputView.showError("다른 사람이 사용하고 있어요.")
                
            case 10:
                self?.nicknameInputView.showError("네트워크 오류가 발생했습니다.")
                
            default:
                break
            }
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}
