//
//  ProductTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class ProductTableViewCell: UITableViewCell,ReuseIdentifying {
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .black
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupUI()
        setupConstraints()
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ProductTableViewCell {
    private func setupUI() {
        self.addSubviews(containerView)
        
        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview().inset(8)
        }
    }
}
