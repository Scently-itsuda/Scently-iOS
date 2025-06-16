//
//  AccordButtonCell.swift
//  Scently
//
//  Created by 임재현 on 6/13/25.
//

import UIKit
import SnapKit


class AccordButtonCell: UICollectionViewCell {
    let optionButton = OptionButton(title: "")
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        contentView.addSubview(optionButton)
        optionButton.isUserInteractionEnabled = false
        optionButton.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }

    }
    
    func configure(with title: String, tag: Int, isSelected: Bool) {
        optionButton.configure(with: title)
        optionButton.tag = tag
        optionButton.updateSelectedState(isSelected: isSelected)
        
        DispatchQueue.main.async {
            print("셀 \(tag) 실제 frame: \(self.frame)")
            print("셀 \(tag) 버튼 frame: \(self.optionButton.frame)")
        }
    }
}
