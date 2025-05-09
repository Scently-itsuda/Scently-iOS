//
//  NavigationView.swift
//  Scently
//
//  Created by sy0201 on 5/9/25.
//

import UIKit
import SnapKit

final class NavigationView: UIView {
    private let containerView: UIView = {
        let containerView = UIView()
        return containerView
    }()
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-search2"), for: .normal)
        return button
    }()
    
    private let alertButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-bell2"), for: .normal)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
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

private extension NavigationView {
    func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(logoStackView)
        
        self.buttonStackView.addArrangedSubview(searchButton)
        self.buttonStackView.addArrangedSubview(alertButton)
        
        logoStackView.backgroundColor = .clear
        self.logoStackView.addArrangedSubview(logoImageView)
        self.logoStackView.addArrangedSubview(spacerView)
        self.logoStackView.addArrangedSubview(buttonStackView)
    }
    
    func setupConstraint() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
        
        logoStackView.snp.makeConstraints {
            $0.top.equalTo(self.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self.safeAreaInsets).offset(20)
            $0.trailing.equalTo(self.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(24)
        }
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(108)
            $0.height.equalTo(20)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.height.equalTo(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        alertButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
    }
    
    func setAddtarget() {
        searchButton.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(alertButtonDidTap), for: .touchUpInside)
    }
    
    @objc
    func searchButtonDidTap() {
        print("searchButtonDidTap")
    }
    
    @objc
    func alertButtonDidTap() {
        print("alertButtonDidTap")
    }
}
