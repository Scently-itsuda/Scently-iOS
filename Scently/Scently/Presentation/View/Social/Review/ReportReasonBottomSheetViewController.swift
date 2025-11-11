//
//  ReportReasonBottomSheetViewController.swift
//  Scently
//
//  Created by 임재현 on 11/8/25.
//

import UIKit
import SnapKit

final class ReportReasonBottomSheetViewController: UIViewController {
    
    var onReasonSelected: ((ReportReason) -> Void)?
    
    // 컨테이너 뷰 추가
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        view.layer.cornerRadius = 16
        view.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        return view
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "신고 사유 선택"
        label.font = .systemFont(ofSize: 18, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private let stackView: UIStackView = {
        let stack = UIStackView()
        stack.axis = .vertical
        stack.spacing = 0
        stack.distribution = .fill
        return stack
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupReasonButtons()
        setupGesture()
    }
}

extension ReportReasonBottomSheetViewController {
    private func setupUI() {
        view.backgroundColor = UIColor.black.withAlphaComponent(0.5) // ✅ 반투명 배경
        view.addSubview(containerView)
        containerView.addSubviews(titleLabel, stackView)
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints { make in
            make.leading.trailing.bottom.equalToSuperview()
            make.height.equalTo(500) // 필요에 따라 조정
        }
        
        titleLabel.snp.makeConstraints { make in
            make.top.equalToSuperview().offset(24)
            make.leading.equalToSuperview().offset(20)
        }
        
        stackView.snp.makeConstraints { make in
            make.top.equalTo(titleLabel.snp.bottom).offset(20)
            make.leading.trailing.equalToSuperview().inset(20)
        }
    }
    
    private func setupReasonButtons() {
        let reasons: [ReportReason] = [
            .spam,
            .badWords,
            .sexual,
            .repetitive,
            .personalInfo,
            .other
        ]
        
        for (index, reason) in reasons.enumerated() {
            let button = createReasonButton(reason: reason)
            stackView.addArrangedSubview(button)
            
            // 마지막 버튼이 아니면 divider 추가
            if index < reasons.count - 1 {
                stackView.addArrangedSubview(createDivider())
            }
        }
    }
    
    private func createReasonButton(reason: ReportReason) -> UIButton {
        let button = UIButton(type: .system)
        button.setTitle(reason.rawValue, for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .regular)
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 16, left: 0, bottom: 16, right: 0)
        
        button.addAction(UIAction { [weak self] _ in
            self?.reasonSelected(reason)
        }, for: .touchUpInside)
        
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
    
    private func setupGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(backgroundTapped))
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }
    
    @objc private func backgroundTapped() {
        dismiss(animated: true)
    }
    
    private func reasonSelected(_ reason: ReportReason) {
        dismiss(animated: true) { [weak self] in
            self?.onReasonSelected?(reason)
        }
    }
}

extension ReportReasonBottomSheetViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        return touch.view == self.view
    }
}

