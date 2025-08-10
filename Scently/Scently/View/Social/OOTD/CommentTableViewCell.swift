//
//  CommentTableViewCell.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class CommentTableViewCell: UITableViewCell,ReuseIdentifying {
    
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

extension CommentTableViewCell {
    private func setupUI() {
        self.addSubviews(containerView)
        

        selectionStyle = .none
        backgroundColor = .clear
    }
    
    private func setupConstraints() {
        containerView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.bottom.equalToSuperview().inset(6)
        }
    }
}

