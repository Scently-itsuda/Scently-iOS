//
//  ReviewActionBottomSheetViewController.swift
//  Scently
//
//  Created by 임재현 on 11/8/25.
//

import UIKit
import SnapKit



final class ReviewActionBottomSheetViewController: UIViewController {
    
    private let isMyReview: Bool
    
    var onEditTapped: (() -> Void)?
    var onDeleteTapped: (() -> Void)?
    var onReportTapped: (() -> Void)?
        
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 8
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        return stack
    }()
    
    private lazy var editButton: UIButton = {
        return createActionButton(
            iconName: "pencil",
            title: "글 수정하기",
            action: #selector(editTapped)
        )
    }()
    
    private lazy var deleteButton: UIButton = {
        return createActionButton(
            iconName: "trash",
            title: "글 삭제하기",
            action: #selector(deleteTapped)
        )
    }()
    
    private lazy var reportButton: UIButton = {
        return createActionButton(
            iconName: "exclamationmark.bubble",
            title: "글 신고하기",
            action: #selector(reportTapped)
        )
    }()
    
    
    init(isMyReview: Bool) {
        self.isMyReview = isMyReview
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

extension ReviewActionBottomSheetViewController {
    
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5)
        view.addSubview(containerView)
        containerView.addSubview(stackView)
        
        if isMyReview {
            stackView.addArrangedSubview(editButton)
            stackView.addArrangedSubview(createDivider())
            stackView.addArrangedSubview(deleteButton)
            stackView.addArrangedSubview(createDivider())
        }
        stackView.addArrangedSubview(reportButton)
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    private func setupConstraints() {
        let buttonHeight: CGFloat = 56
        let dividerHeight: CGFloat = 1
        let verticalPadding: CGFloat = 32
        
        let totalStackHeight: CGFloat
        if isMyReview {
            totalStackHeight = (buttonHeight * 3) + (dividerHeight * 2)
        } else {
            totalStackHeight = buttonHeight
        }
        
        let totalHeight = totalStackHeight + verticalPadding
        
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(totalHeight)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(16)
            make.leading.equalToSuperview().offset(20)
            make.trailing.equalToSuperview().offset(-20)
            make.bottom.equalToSuperview().offset(-16)
        }
    }
    
    private func createActionButton(iconName: String, title: String, action: Selector) -> UIButton {
        let button = UIButton(type: .system)
        button.contentHorizontalAlignment = .left
        
        button.snp.makeConstraints { make in
            make.height.equalTo(56)
        }
        
        // 아이콘 설정
        let iconConfig = UIImage.SymbolConfiguration(pointSize: 16, weight: .medium)
        let icon = UIImage(systemName: iconName, withConfiguration: iconConfig)
        button.setImage(icon, for: .normal)
        button.tintColor = .black
        button.imageView?.contentMode = .scaleAspectFit
        
        // 텍스트 설정
        button.setTitle(title, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)

        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 12)
        button.titleEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 0)
        
        
        button.addTarget(self, action: action, for: .touchUpInside)
        
        return button
    }
    
    private func createDivider() -> UIView {
        let divider = UIView()
        divider.backgroundColor = .systemGray5
        divider.snp.makeConstraints { make in
            make.height.equalTo(1)
        }
        return divider
    }
}

extension ReviewActionBottomSheetViewController {
    
    @objc private func editTapped() {
        dismiss(animated: true) {
            print("글 수정하기 tapped")
            // TODO: 수정 로직 (e.g., 델리게이트 호출)
        }
    }
    
    @objc private func deleteTapped() {
        dismiss(animated: true) {
            print("글 삭제하기 tapped")
            // TODO: 삭제 로직
        }
    }
    
    @objc private func reportTapped() {
        dismiss(animated: true) {
            print("글 신고하기 tapped")
            // TODO: 신고 로직
            self.onReportTapped?()
        }
    }
    
    @objc private func backgroundTapped() {
        dismiss(animated: true, completion: nil)
    }
}

extension ReviewActionBottomSheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}
