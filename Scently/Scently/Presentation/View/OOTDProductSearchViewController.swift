//
//  OOTDProductSearchViewController.swift
//  Scently
//
//  Created by 임재현 on 11/22/25.
//

import UIKit
import SnapKit

final class OOTDProductSearchViewController: UIViewController {
    
    
    var onCompleteTapped: (([Product]) -> Void)?
    
    private var selectedProducts: [Product] = []
    
    private let navigationBar: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private lazy var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "제품 선택"
        label.font = .systemFont(ofSize: 18, weight: .semibold)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var completeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("완료", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(completeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let tempLabel: UILabel = {
        let label = UILabel()
        label.text = "게시글에 등록할 제품을 검색해주세요."
        label.numberOfLines = 0
        label.textAlignment = .center
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .systemGray
        return label
    }()
    
    
    let dividerView = DividerView()
    
    let customSearchBar = SearchBarView(
        configuration: .init(
            placeholder: "제품명 또는 브랜드 검색",
            showBottomView: false
        )
    )
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
    }
    
    private func setupUI() {
        view.addSubviews(navigationBar,dividerView,customSearchBar,tempLabel)
        navigationBar.addSubviews(backButton, titleLabel, completeButton)
    }
    
    private func setupConstraints() {
        navigationBar.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(44)
        }
        
        backButton.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(16)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(44)
        }
        
        titleLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
        
        completeButton.snp.makeConstraints {
            $0.trailing.equalToSuperview().offset(-16)
            $0.centerY.equalToSuperview()
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(22)
            $0.leading.trailing.equalToSuperview()
        }
        
        customSearchBar.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        tempLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    
    func configure(with products: [Product]) {
        self.selectedProducts = products
        print("ProductSearchVC에 전달된 제품:", products.count)
    }
    
    
    @objc private func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func completeButtonTapped() {
        onCompleteTapped?(selectedProducts)
    }
}
