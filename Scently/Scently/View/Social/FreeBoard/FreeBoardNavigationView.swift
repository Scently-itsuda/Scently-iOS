//
//  FreeBoardNavigationView.swift
//  Scently
//
//  Created by 임재현 on 8/15/25.
//

import UIKit
import SnapKit

protocol FreeBoardNavigationViewDelegate: AnyObject {
    func didTapBackButton()
    func didTapAlertButton()
}

final class FreeBoardNavigationView: UIView {
    
    weak var delegate: FreeBoardNavigationViewDelegate?
    
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let backButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-back"), for: .normal)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.font = .pretendard(.bold, size: 16)
        titleLabel.text = "글 상세"
        titleLabel.textColor = .black
        
        return titleLabel
    }()

    private let alertButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-bell2"), for: .normal)
        return button
    }()

    private let logoStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .blue
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let dividerView = DividerView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraint()
        setAddtarget()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private extension FreeBoardNavigationView {
    func setupUI() {
        self.addSubviews(containerView,dividerView)
        self.containerView.addSubviews(backButton, titleLabel, alertButton)
    }
    
    func setupConstraint() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
    
        backButton.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self.safeAreaLayoutGuide).offset(16)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.leading.equalTo(backButton.snp.trailing).offset(4)
            $0.centerY.equalTo(backButton.snp.centerY)
        }
        
        alertButton.snp.makeConstraints {
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.width.height.equalTo(24)
        }
        
        dividerView.snp.makeConstraints {
            $0.bottom.equalTo(containerView.snp.bottom)
            $0.leading.trailing.equalToSuperview()
        }
    }
    
    func setAddtarget() {
        backButton.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(alertButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func backButtonDidTap() {
        print("backButtonDidTap")
        delegate?.didTapBackButton()
    }
    
    @objc
    func alertButtonDidTap() {
        print("alertButtonDidTap")
        delegate?.didTapAlertButton()
    }
}
