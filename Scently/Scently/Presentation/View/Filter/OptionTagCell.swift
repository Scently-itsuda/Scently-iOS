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
    private let optionButton = OptionButton(title: "123")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        optionButton.updateSelectedState(isSelected: false)
    }
    
    private func setupUI() {
        self.addSubview(optionButton)
        optionButton.isUserInteractionEnabled = false
        optionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(with text: String, isSelected: Bool) {
        self.optionButton.configure(with: text)
        optionButton.updateSelectedState(isSelected: isSelected)
    }
}
