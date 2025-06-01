//
//  OptionTagCell.swift
//  Scently
//
//  Created by 임재현 on 5/31/25.
//

import UIKit
import SnapKit

final class OptionTagCell: UICollectionViewCell {
    
    static let reuseIdentifier = "OptionTagCell"
    private let optionButton = OptionButton(title: "123",hasImage: true)
    
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
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with text: String) {
        self.optionButton.configure(with: text)
    }
}
