//
//  FloatingButton.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit

final class FloatingActionItemView: UIView {
    weak var delegate: FloatingActionItemDelegate?

    let iconButton = UIButton(type: .custom)
    let titleLabel = UILabel()
    
    private let title: String

    init(title: String, iconName: String) {
        self.title = title
        super.init(frame: .zero)
        setupUI(title: title, iconName: iconName)
        setupGesture()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI(title: String, iconName: String) {
        titleLabel.text = title
        titleLabel.font = .systemFont(ofSize: 14)
        titleLabel.textColor = .white
        titleLabel.textAlignment = .right
        
        iconButton.setImage(UIImage(systemName: iconName), for: .normal)
        iconButton.tintColor = .white
        iconButton.backgroundColor = .black
        iconButton.layer.cornerRadius = 20
        iconButton.snp.makeConstraints { $0.width.height.equalTo(40) }
        
        let hStack = UIStackView(arrangedSubviews: [titleLabel, iconButton])
        hStack.spacing = 8
        hStack.alignment = .center
        addSubview(hStack)
        
        hStack.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    // 새로 추가할 메서드들
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(didTapView))
        self.addGestureRecognizer(tapGesture)
        self.isUserInteractionEnabled = true
    }
    
    @objc private func didTapView() {
        delegate?.didTapFloatingActionItem(with: title)  // 이제 title에 접근 가능
    }
}
