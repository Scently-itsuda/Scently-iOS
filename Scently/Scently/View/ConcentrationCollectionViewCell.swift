//
//  ConcentrationCollectionViewCell.swift
//  Scently
//
//  Created by 임재현 on 5/10/25.
//

import UIKit
import SnapKit

protocol ReuseIdentifiable {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifiable {
    static var reuseIdentifier: String { String(describing: Self.self) }
}


class ConcentrationCollectionViewCell: UICollectionViewCell,ReuseIdentifiable {
    private let button: SelectButton
    var onTap: (() -> Void)?
    
    override init(frame: CGRect) {
        button = SelectButton(buttonTitle: "", subTitle: "")
        super.init(frame: .zero)
        setupUI()
        button.addTarget(self, action: #selector(buttonTapped(_:)), for: .touchUpInside)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        self.addSubview(button)
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(title: String, subtitle: String, isSelected: Bool) {
        button.updateTitles(title: title, subTitle: subtitle)
        button.isSelected = isSelected
        
    }
    
    @objc func buttonTapped(_ sender:SelectButton) {
        sender.isSelected.toggle()
        onTap?()
    }
}
