//
//  OptionButton.swift
//  Scently
//
//  Created by 임재현 on 5/25/25.
//

import UIKit
import SnapKit

final class OptionButton: UIButton {
  
    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon-best-off")
        return imageView
    }()
    
    private let buttonTitle: UILabel = {
       let label = UILabel()
        label.font = .pretendard(.regular, size: 11)
        label.textColor = .gray3
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    init(borderColor: UIColor = .lightgray,cornerRadius:CGFloat = 8,title: String,hasImage:Bool = false,image:String? = nil) {
        super.init(frame: .zero)

        buttonTitle.text = title
        layer.cornerRadius = cornerRadius
        layer.borderColor = borderColor.cgColor
        layer.borderWidth = 1
        backgroundColor = .white
        setupUI(hasImage: hasImage)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func setupUI(hasImage: Bool) {
        if hasImage {
            self.addSubview(iconImageView)
            self.addSubview(buttonTitle)

            iconImageView.snp.makeConstraints {
                $0.leading.equalToSuperview().offset(8)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(12)
            }

            buttonTitle.snp.makeConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(8)
                $0.centerY.equalToSuperview()
                $0.trailing.lessThanOrEqualToSuperview().inset(8)
            }

        } else {
            self.addSubview(buttonTitle)

            buttonTitle.snp.makeConstraints {
                $0.center.equalToSuperview()
            }
        }
    }

}
