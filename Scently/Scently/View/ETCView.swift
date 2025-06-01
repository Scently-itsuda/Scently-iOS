//
//  ETCView.swift
//  Scently
//
//  Created by 임재현 on 6/1/25.
//

import UIKit
import SnapKit


final class ETCView: UIView {
    private let newProductButton = OptionButton(title: "신상품",hasImage: false)


    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(newProductButton)

        
        newProductButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(20)
        }
        
    }
}
