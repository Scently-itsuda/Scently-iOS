//
//  PriceView.swift
//  Scently
//
//  Created by 임재현 on 5/7/25.
//

import UIKit
import SnapKit

final class PriceView: UIView {

    private let checkButton = CheckButton()

    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(200)
        }
        checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    @objc func checkButtonDidTap() {
        checkButton.isSelected.toggle()
    }
}
