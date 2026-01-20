//
//  FloatingButton.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit

final class FloatingActionItemView: UIView {
    let iconButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    
    init(title: String, iconName: String) {
        super.init(frame: .zero)
        setupUI(title: title, iconName: iconName)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String, iconName: String) {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
        titleLabel.isUserInteractionEnabled = false
        
        iconButton.setImage(UIImage(systemName: iconName), for: .normal)
        iconButton.tintColor = .white
        iconButton.backgroundColor = .black
        iconButton.layer.cornerRadius = 20
        iconButton.isUserInteractionEnabled = false
        iconButton.snp.makeConstraints { $0.width.height.equalTo(40) }
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel, iconButton])
        hStack.spacing = 8
        hStack.alignment = .center
        hStack.isUserInteractionEnabled = false
        addSubview(hStack)
        
        hStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
}
