//
//  PriceView.swift
//  Scently
//
//  Created by 임재현 on 5/7/25.
//

import UIKit
import SnapKit
import Combine

final class PriceView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    @Published var selectedButtonIndex: Int? = nil
    @Published private var minPriceText: String = ""
    @Published private var maxPriceText: String = ""
    private var allButtons: [CheckButton] = []
   
    let priceArrange = [
        "전체", "5만원 이하",
        "5만원 ~ 10만원", "10만원 ~ 20만원",
        "20만원 ~ 30만원", "30만원 이상",
        "직접입력"
    ]
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "가격"
        label.font = .pretendard(.bold, size: 14)
        return label
    }()
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.titleLabel?.font = .pretendard(.regular, size: 10)
        button.setTitleColor(.gray3, for: .normal)
        return button
    }()
    
    private let dividerView = DividerView()
    
    private let checkButtonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 14
        stackView.distribution = .fillEqually
        return stackView
    }()
    
    private let minPriceTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.addRightLabel("원")
        textField.textAlignment = .right
        textField.font = .pretendard(.regular, size: 12)
        textField.textColor = .gray3
        return textField
    }()
    
    private let waveLabel: UILabel = {
        let label = UILabel()
        label.text = "~"
        label.font = .systemFont(ofSize: 12)
        label.textColor = .gray3
        return label
    }()
    
    private let maxPriceTextField: UITextField = {
       let textField = UITextField()
        textField.borderStyle = .roundedRect
        textField.keyboardType = .numberPad
        textField.addRightLabel("원")
        textField.textAlignment = .right
        textField.font = .pretendard(.regular, size: 12)
        textField.textColor = .gray3
        return textField
    }()

    

    private let suffixLabel: UILabel = {
       let label = UILabel()
        label.text = "원"
        label.font = .pretendard(.regular, size: 12)
        label.textColor = .gray3
        label.sizeToFit()
        return label
    }()
    

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setupLayout()
        setBinding()
        setAddTarget()
        setupStackView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(priceLabel)
        self.addSubview(resetButton)
        self.addSubview(dividerView)
        self.addSubview(checkButtonStackView)
        self.addSubview(minPriceTextField)
        self.addSubview(maxPriceTextField)
        self.addSubview(waveLabel)
    }
    
    
    private func setupLayout() {
        priceLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(20)
            $0.leading.equalToSuperview().offset(20)
        }
        
        resetButton.snp.makeConstraints {
            $0.centerY.equalTo(priceLabel.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.width.equalTo(30)
            $0.height.equalTo(12)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
        }

        checkButtonStackView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(20)
            $0.leading.equalToSuperview().inset(8)
        }
        
        minPriceTextField.snp.makeConstraints {
            $0.top.equalTo(checkButtonStackView.snp.bottom).offset(16)
            $0.leading.equalTo(dividerView.snp.leading)
            $0.width.equalTo(108)
            $0.height.equalTo(34)
        }
        
        waveLabel.snp.makeConstraints {
            $0.centerY.equalTo(minPriceTextField.snp.centerY)
            $0.leading.equalTo(minPriceTextField.snp.trailing).offset(8)
        }
        
        maxPriceTextField.snp.makeConstraints {
            $0.top.equalTo(checkButtonStackView.snp.bottom).offset(16)
            $0.leading.equalTo(waveLabel.snp.trailing).offset(8)
            $0.width.equalTo(108)
            $0.height.equalTo(34)
            
        }
    }
    
    private func setBinding() {
        $selectedButtonIndex
            .sink { [weak self] selectedIndex in
                self?.updateButtonStates(selectedIndex: selectedIndex)
                self?.updateTextFieldState(selectedIndex: selectedIndex)
            }
            .store(in: &cancellables)
    }
    
    private func setupStackView() {
        for row in 0..<4 {
            let rowStack = UIStackView()
            rowStack.axis = .horizontal
            rowStack.spacing = 0
            rowStack.distribution = .fillEqually
            rowStack.alignment = .leading
            
            let leftIndex = row * 2
            if leftIndex < priceArrange.count {
                let leftCell = createButton(title: priceArrange[leftIndex])
                rowStack.addArrangedSubview(leftCell)
            }
            
            let rightIndex = row * 2 + 1
            if rightIndex < priceArrange.count {
                let rightCell = createButton(title: priceArrange[rightIndex])
                rowStack.addArrangedSubview(rightCell)
            } else {
                let spacer = UIView()
                rowStack.addArrangedSubview(spacer)
            }
            checkButtonStackView.addArrangedSubview(rowStack)
        }
    }
    
    private func createButton(title: String) -> UIView {
        let buttons = CheckButton(title: title)
        buttons.backgroundColor = .white
        let maxWidth = priceArrange.map { title in
            let boldFont = UIFont.pretendard(.bold, size: 12)
            let textSize = (title as NSString).size(withAttributes: [.font: boldFont])
            return textSize.width + 50 
        }.max() ?? 140
        
        buttons.snp.makeConstraints {
            $0.width.equalTo(maxWidth)
        }
        
        allButtons.append(buttons)
        buttons.addTarget(self, action: #selector(checkButtonTapped(_:)), for: .touchUpInside)
        
        return buttons
    }
    
    private func updateButtonStates(selectedIndex: Int?) {
        for (index, button) in allButtons.enumerated() {
            let shouldBeSelected = index == selectedIndex
        print("버튼 \(index): 현재상태=\(button.buttonState), 변경될상태=\(shouldBeSelected)")
            if button.buttonState != shouldBeSelected {
                button.buttonState = shouldBeSelected
            }
        }
    }
    
    private func updateTextFieldState(selectedIndex: Int?) {
        let isDirectInputSelected = selectedIndex == 6
        
        
        
        minPriceTextField.isEnabled = isDirectInputSelected
        maxPriceTextField.isEnabled = isDirectInputSelected
        
        
        
        if isDirectInputSelected {
            minPriceTextField.becomeFirstResponder()
        } else {
            minPriceTextField.text = nil
            maxPriceTextField.text = nil
            
            minPriceText = ""
            maxPriceText = ""
            
            minPriceTextField.resignFirstResponder()
            maxPriceTextField.resignFirstResponder()
        }
        

        minPriceTextField.alpha = isDirectInputSelected ? 1.0 : 0.5
        maxPriceTextField.alpha = isDirectInputSelected ? 1.0 : 0.5
        waveLabel.alpha = isDirectInputSelected ? 1.0 : 0.5
        minPriceTextField.backgroundColor = isDirectInputSelected ? .white : .systemGray6
        maxPriceTextField.backgroundColor = isDirectInputSelected ? .white : .systemGray6
    }
    
    private func setAddTarget() {
        resetButton.addTarget(self, action: #selector(resetButtonDidTap), for: .touchUpInside)
        
        minPriceTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)
        maxPriceTextField.addTarget(self, action: #selector(textFieldDidChange(_:)), for: .editingChanged)

        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
           tapGesture.cancelsTouchesInView = false
           self.addGestureRecognizer(tapGesture)
    }
    
    @objc private func checkButtonTapped(_ sender: CheckButton) {
        guard let index = allButtons.firstIndex(of: sender) else { return}
            if selectedButtonIndex == index {
                selectedButtonIndex = nil
            } else {
                selectedButtonIndex = index
            }
    }
    
    @objc private func dismissKeyboard() {
        self.endEditing(true)
    }
    
    @objc private func resetButtonDidTap() {
        allButtons.forEach { $0.buttonState = false }
        selectedButtonIndex = nil
    }
    // MARK: - ToDo - 추후에 ViewModel, VC 로 로직 분리
    
    @objc private func textFieldDidChange(_ textField: UITextField) {
        // 1. 쉼표 제거된 숫자 문자열
        let rawText = textField.text?.replacingOccurrences(of: ",", with: "") ?? ""

        // 2. 최대 9자리까지만 허용
        guard rawText.count <= 9 else {
            // 초과된 입력을 자르고 포맷
            let limitedText = String(rawText.prefix(9))
            if let number = Int(limitedText) {
                textField.text = formatNumber(number)
            }
            return
        }

        // 3. 정상 입력 포맷 처리
        if let number = Int(rawText) {
            textField.text = formatNumber(number)
        } else {
            textField.text = ""
        }
        
        switch textField {
        case minPriceTextField:
            minPriceText = textField.text ?? ""
        case maxPriceTextField:
            maxPriceText = textField.text ?? ""
        default:
            break
        }
    }

    private func formatNumber(_ value: Int) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter.string(from: NSNumber(value: value)) ?? ""
    }
}

extension PriceView {
    
    struct PriceSelection {
        let selectedOption: String?
        let minPrice: String?
        let maxPrice: String?
        let isDirectInput: Bool
        
        var isEmpty: Bool {
            return selectedOption == nil && (minPrice?.isEmpty ?? true) && (maxPrice?.isEmpty ?? true)
        }
    }
    
    
    var selectedPricePublisher: AnyPublisher<String?,Never> {
        return $selectedButtonIndex
            .map { [weak self] index  in
                guard let self = self, let index = index else {return nil}
                return self.priceArrange[index]
            }
            .eraseToAnyPublisher()
    }
    
    var priceSelectionPublisher: AnyPublisher<PriceSelection,Never> {
        return Publishers.CombineLatest3 (
            $selectedButtonIndex,
            $minPriceText,
            $maxPriceText
        )
        .map { [weak self] (buttonIndex, minText, maxText) in
            guard let self = self else {
                return PriceSelection(selectedOption: nil, minPrice: nil, maxPrice: nil, isDirectInput: false)
            }
            let selectedOption = buttonIndex.map { self.priceArrange[$0] }
            let isDirectInput = selectedOption == "직접입력"
            
            return PriceSelection(
                selectedOption: selectedOption,
                minPrice: isDirectInput && !minText.isEmpty ? minText : nil,
                maxPrice: isDirectInput && !maxText.isEmpty ? maxText : nil,
                isDirectInput: isDirectInput
            )
        }
        .eraseToAnyPublisher()
    }
}
