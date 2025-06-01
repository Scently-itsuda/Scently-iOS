//
//  GenderView.swift
//  Scently
//
//  Created by 임재현 on 5/30/25.
//

import UIKit
import SnapKit

final class GenderView: UIView {
    private let allButton = OptionButton(title: "전체",hasImage: false)
    private let maleButton = OptionButton(title: "남성",hasImage: false)
    private let femaleButton = OptionButton(title: "여성",hasImage: false)
    
    

    
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
}
