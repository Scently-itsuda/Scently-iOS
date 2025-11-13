//
//  UserInfoViewController.swift
//  Scently
//
//  Created by 임재현 on 6/19/25.
//

import UIKit
import SnapKit
import Combine

final class SignUpViewController: UIViewController {
    
    weak var coordinator: SignUpCoordinator?
    var socialToken: String?
    
    private let viewModel: SignupViewModel
    private var cancellables = Set<AnyCancellable>()
    
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
        button.setTitle("완료하기", for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 16)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 8
        return button
    }()
    
    init(viewModel: SignupViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupLayout()
        createGenderButtons()
        setupNicknameInput()
        setupBirthDateInput()
        setupKeyboardHandling()
        setupTapGesture()
        setUpAddTargets()
        bindViewModel()
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
    
    private func setUpAddTargets() {
        completeButton.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
    }
    
    @objc private func completeButtonTapped() {
        let result = viewModel.canSubmit()
        
        if !result.canSubmit, let errorMessage = result.errorMessage {
            // 에러 메시지 표시 (간단하게 alert로)
            showAlert(message: errorMessage)
            return
        }
        coordinator?.didCompleteSignUp()
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
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
        tapGesture.delegate = self
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
            self?.viewModel.nickname = text
        }
        
        nicknameInputView.onDuplicateCheck = { [weak self] nickname in
            Task {
                await self?.viewModel.checkNicknameDuplicate()
            }
        }
    }
    
    private func setupBirthDateInput() {
        birthDateInputView.onDateSelected = { [weak self] date in
            self?.viewModel.birthDate = date
        }
        
        birthDateInputView.onPrivateToggle = { [weak self] isPrivate in
            self?.viewModel.isBirthDatePrivate = isPrivate
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
    
    private func bindViewModel() {
        
        viewModel.$isFormValid
            .receive(on: DispatchQueue.main)
            .sink { [weak self] isValid in
                self?.updateCompleteButton(isEnabled: isValid)
            }
            .store(in: &cancellables)
        
        viewModel.$nicknameValidationState
            .receive(on: DispatchQueue.main)
            .sink { [weak self] state in
                self?.updateNicknameInputView(state: state)
            }
            .store(in: &cancellables)
        
        viewModel.$shouldHilightedDuplicatedCheck
            .receive(on: DispatchQueue.main)
            .sink { [weak self] shouldHighlight in
                self?.nicknameInputView.highlightDuplicateCheckButton(shouldHighlight)
            }
            .store(in: &cancellables)
    }
    
    private func updateCompleteButton(isEnabled: Bool) {
        completeButton.isEnabled = isEnabled
        completeButton.backgroundColor = isEnabled ? .black : .gray3
        completeButton.alpha = isEnabled ? 1.0 : 0.6
    }
    
    private func updateNicknameInputView(state: NicknameValidationState) {
        switch state {
        case .empty:
            nicknameInputView.hideError()
            nicknameInputView.hideLoading()
            nicknameInputView.setDuplicateCheckEnabled(false)
            
        case .invalid(let reason):
            nicknameInputView.showError(reason)
            nicknameInputView.hideLoading()
            nicknameInputView.setDuplicateCheckEnabled(false)
            
        case .validButNotChecked:
            nicknameInputView.hideError()
            nicknameInputView.hideLoading()
            nicknameInputView.setDuplicateCheckEnabled(true)
            
        case .checking:
            nicknameInputView.hideError()
            nicknameInputView.setDuplicateCheckEnabled(false)
            nicknameInputView.showLoading()
            
        case .available:
            nicknameInputView.showSuccess("사용 가능한 닉네임 입니다")
            nicknameInputView.setDuplicateCheckEnabled(false)
            
        case .duplicate:
            nicknameInputView.showError("다른 사람이 사용하고 있어요")
            nicknameInputView.setDuplicateCheckEnabled(true)
            
        case .error(let message):
            nicknameInputView.showError(message)
            nicknameInputView.setDuplicateCheckEnabled(true)
        }
    }
    
    @objc private func genderButtonTapped(_ sender: OptionButton) {
        let tappedGender = orderedGenders[sender.tag]
        
        selectedGender = (selectedGender == tappedGender) ? nil : tappedGender
        updateGenderButtonsUI()
        
        print("선택된 성별: \(selectedGender?.titleForInfo ?? "선택 안함")")
        viewModel.selectedGender = selectedGender
    }
    
    private func updateGenderButtonsUI() {
        orderedGenders.enumerated().forEach { index, gender in
            let button = genderButtons[index]
            let isSelected = selectedGender == gender
            button.updateSelectedState(isSelected: isSelected)
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
}

extension SignUpViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // 터치된 뷰가 중복확인 버튼이면 제스처를 무시
        if let touchedView = touch.view,
           touchedView.isDescendant(of: nicknameInputView) {
            // NicknameInputView 내부의 어떤 버튼이나 컨트롤이면
            if touchedView is UIButton || touchedView is UIControl {
                return false // 키보드 안 내려감
            }
        }
        return true // 다른 곳 터치하면 키보드 내려감
    }
}
