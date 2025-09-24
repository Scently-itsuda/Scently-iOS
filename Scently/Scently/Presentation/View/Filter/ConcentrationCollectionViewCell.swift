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
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        button.isSelected = false
        button.backgroundColor = .gray4
        button.buttonTitle.textColor = .gray3
        button.buttonSubTitle.textColor = .gray3
    }
    
    private func setupUI() {
        self.addSubview(button)
        button.isUserInteractionEnabled = false
        button.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func configure(title: String, subtitle: String, isSelected: Bool) {
        button.updateTitles(title: title, subTitle: subtitle)
        button.isSelected = isSelected
        
    }
    
    @objc func buttonTapped(_ sender:SelectButton) {
        onTap?()
    }
}
