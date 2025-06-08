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
        return button
    }()
    
    private var buttonType:ButtonType = .delete {
        didSet {
            configureButtonImage()
        }
    }
    
    private var isFilterApplied: Bool = false {
        didSet {
            updateAppearanceForFilter()
        }
    }
    
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
        titleLabel.textColor = .gray3
        
        setupUI()
        setupActions()
        configureButtonImage()
        
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
            $0.size.equalTo(8)
        }
    }
    
    private func setupActions() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
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

extension TagListView {
    func setFilterApplied(_ applied: Bool) {
        print("setFilterApplied 호출 - title: \(titleLabel.text ?? "unknown"), applied: \(applied)")
        
        isFilterApplied = applied
        buttonType = applied ? .delete : .dropDown
        
        // 즉시 UI 업데이트
        DispatchQueue.main.async { [weak self] in
            self?.updateAppearanceForFilter()
            self?.configureButtonImage()
        }
    }
    
    private func updateAppearanceForFilter() {
        if isFilterApplied {
            layer.borderColor = UIColor.black.cgColor
            layer.borderWidth = 1.0
            titleLabel.textColor = .black
            titleLabel.font = .pretendard(.medium, size: 11)
            actionButton.tintColor = .black
        } else {
            layer.borderColor = UIColor.lightgray.cgColor
            layer.borderWidth = 1
            titleLabel.textColor = .gray3
            titleLabel.font = .pretendard(.regular, size: 11)
            actionButton.tintColor = .gray3
        }
    }
    
    private func configureButtonImage() {
        switch buttonType {
        case .delete:
            let image = UIImage(systemName: "xmark")
            actionButton.setImage(image, for: .normal)
        case .dropDown:
            let image = UIImage(systemName: "chevron.down")
            actionButton.setImage(image, for: .normal)
        }
    }
}
