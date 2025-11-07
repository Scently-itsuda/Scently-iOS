//
//  SelectButton.swift
//  Scently
//
//  Created by 임재현 on 5/9/25.
//

import UIKit
import SnapKit

final class SelectButton: UIButton {
    
     let buttonTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray3
        label.font = .pretendard(.medium, size: 12)
        label.textAlignment = .center
        return label
    }()
    
     let buttonSubTitle: UILabel = {
        let label = UILabel()
        label.textColor = .gray3
        label.font = .pretendard(.light, size:8)
        label.textAlignment = .center
        return label
    }()

    init(buttonTitle:String, subTitle:String) {
        super.init(frame: .zero)
        setupUI(title: buttonTitle, subTitle: subTitle)
        self.backgroundColor = .gray4
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setupUI(title:String, subTitle:String) {
        buttonTitle.text = title
        buttonSubTitle.text = subTitle
        self.addSubview(buttonTitle)
        self.addSubview(buttonSubTitle)
        
        buttonTitle.snp.makeConstraints {
            $0.top.equalToSuperview().offset(8)
            $0.centerX.equalToSuperview()
        }
        
        buttonSubTitle.snp.makeConstraints {
            $0.top.equalTo(buttonTitle.snp.bottom).offset(2)
            $0.centerX.equalToSuperview()
        }
        
        
        self.layer.cornerRadius = 8
    }
    
    func updateTitles(title: String, subTitle: String) {
        buttonTitle.text = title
        buttonSubTitle.text = subTitle
    }
    
    override var isSelected: Bool {
        didSet {
            updateStyle()
        }
    }
    
    private func updateStyle() {
        if isSelected {
            self.backgroundColor = .black
            buttonTitle.textColor = .white
            buttonSubTitle.textColor = .white
        } else {
            self.backgroundColor = .gray4
            buttonTitle.textColor = .gray3
            buttonSubTitle.textColor = .gray3
        }
    }
 
}
