//
//  GenderView.swift
//  Scently
//
//  Created by 임재현 on 5/30/25.
//

import UIKit
import SnapKit
import Combine

final class GenderView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    @Published private var selectedGender: Gender? = nil
    
    enum Gender: String, CaseIterable {
        case all = "전체"
        case male = "남성"
        case female = "여성"
        
        var title: String {
            switch self {
            case .all: return "전체"
            case .male: return "남성"
            case .female: return "여성"
            }
        }
    }
    
    private let allButton = OptionButton(title: Gender.all.rawValue, hasImage: false)
    private let maleButton = OptionButton(title: Gender.male.rawValue, hasImage: false)
    private let femaleButton = OptionButton(title: Gender.female.rawValue, hasImage: false)
    
    

    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .equalSpacing
        stackView.alignment = .center
        stackView.spacing = 12
        return stackView

    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setAddTarget()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(buttonStackView)
        self.buttonStackView.addArrangedSubview(allButton)
        self.buttonStackView.addArrangedSubview(maleButton)
        self.buttonStackView.addArrangedSubview(femaleButton)
        
        allButton.snp.makeConstraints {
            $0.width.equalTo(49)
            $0.height.equalTo(28)
        }
        
        maleButton.snp.makeConstraints {
            $0.width.equalTo(49)
            $0.height.equalTo(28)
        }
        
        femaleButton.snp.makeConstraints {
            $0.width.equalTo(49)
            $0.height.equalTo(28)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setAddTarget() {
        allButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        maleButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
        femaleButton.addTarget(self, action: #selector(buttonDidTap(_:)), for: .touchUpInside)
    }
    
    private func setBinding() {
        $selectedGender
            .sink { [weak self] gender in
                self?.updateButtonStates(selectedGender: gender)
            }
            .store(in: &cancellables)
    }
    
    private func updateButtonStates(selectedGender: Gender?) {
        updateButtonAppearance(allButton, isSelected: selectedGender == .all)
        updateButtonAppearance(maleButton, isSelected: selectedGender == .male)
        updateButtonAppearance(femaleButton, isSelected: selectedGender == .female)
    }
    
    private func updateButtonAppearance(_ button: OptionButton, isSelected: Bool) {
        button.updateSelectedState(isSelected: isSelected)
    }
    
    
    @objc private func buttonDidTap(_ sender: OptionButton) {
        let tappedButtonType: Gender?
        
        switch sender {
        case allButton: tappedButtonType = .all
        case maleButton: tappedButtonType = .male
        case femaleButton: tappedButtonType = .female
        default: tappedButtonType = nil
        }
        
        //ToDO: - 버튼 주변에 잔상? 같은거 남는 문제 해결
        DispatchQueue.main.async { [weak self] in
             self?.selectedGender = self?.selectedGender == tappedButtonType ? nil : tappedButtonType
         }
    }
}
