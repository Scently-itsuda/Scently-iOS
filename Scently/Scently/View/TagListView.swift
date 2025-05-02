//
//  TagListView.swift
//  Scently
//
//  Created by 임재현 on 4/30/25.
//

import UIKit
import SnapKit

enum ButtonType {
    case delete
    case dropDown
}

final class TagListView: UIView {
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.regular, size: 11)
        label.textColor = .gray3
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    private let actionButton: UIButton = {
        let button = UIButton(type: .system)
        button.tintColor = .gray
//        button.backgroundColor = .red
        return button
    }()
    
    private var buttonType:ButtonType = .delete
    
    var onAction:(()->Void)?
    var onTap: (()->Void)?

    
    init(borderColor: UIColor = .lightgray,cornerRadius:CGFloat = 8,title: String, buttonType:ButtonType) {
        super.init(frame: .zero)
        self.buttonType = buttonType
        titleLabel.text = title
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1
        backgroundColor = .white
        
        setupUI()
        setupActions()
        congifureButtonImage()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(titleLabel)
        addSubview(actionButton)

        titleLabel.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
           // $0.top.bottom.equalToSuperview().inset(6)
        }
        
        actionButton.snp.makeConstraints {
            $0.leading.equalTo(titleLabel.snp.trailing).offset(8)
            $0.trailing.equalToSuperview().inset(8)
            $0.centerY.equalToSuperview()
            $0.size.equalTo(16)
        }
    }
    
    private func congifureButtonImage() {
        switch buttonType {
        case .delete:
            let image = UIImage(systemName: "xmark")
            actionButton.setImage(image, for: .normal)
        case .dropDown:
            let image = UIImage(systemName: "chevron.down")
            actionButton.setImage(image, for: .normal)
        }
    }
    
    
    
    
    private func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
//        tap.numberOfTapsRequired = 1
//        tap.isEnabled = true
//        tap.cancelsTouchesInView = false
        addGestureRecognizer(tap)
        actionButton.addTarget(self, action: #selector(handleAction), for: .touchUpInside)
    }
    
    @objc
    func handleTap() {
        onTap?()
    }
    
    @objc
    func handleAction() {
        onAction?()
    }
}
