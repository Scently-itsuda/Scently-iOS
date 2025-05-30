//
//  NationView.swift
//  Scently
//
//  Created by 임재현 on 5/25/25.
//

import UIKit
import SnapKit

final class NationView: UIView {
    
    private let optionButton = OptionButton(title: "123",hasImage: false)
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(optionButton)
        
        optionButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.width.equalTo(60)
            $0.height.equalTo(28)
        }
    }

}
