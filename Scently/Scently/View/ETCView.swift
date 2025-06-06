//
//  ETCView.swift
//  Scently
//
//  Created by 임재현 on 6/1/25.
//

import UIKit
import SnapKit
import Combine


final class ETCView: UIView {
    
    private var cancellables = Set<AnyCancellable>()
    @Published private var isNewProductSelected: Bool = false
    
    private let newProductButton = OptionButton(title: "신상품",hasImage: false)


    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupUI()
        setAddTarget()
        setBinding()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(newProductButton)

        newProductButton.snp.makeConstraints {
            $0.width.equalTo(60)
            $0.height.equalTo(28)
            $0.top.equalToSuperview().offset(60)
            $0.leading.equalToSuperview().offset(20)
        }
    }
    
    private func setAddTarget() {
        newProductButton.addTarget(self, action: #selector(newProductButtonTapped), for: .touchUpInside)
    }
    
    private func setBinding() {
        $isNewProductSelected
            .sink { [weak self] isSelected in
                self?.newProductButton.updateSelectedState(isSelected: isSelected)
            }
            .store(in: &cancellables)
    }

    @objc private func newProductButtonTapped() {
        isNewProductSelected.toggle()
    }
}

extension ETCView {
    var isNewProductSelectedPublisher: AnyPublisher<Bool, Never> {
        return $isNewProductSelected.eraseToAnyPublisher()
    }
}
