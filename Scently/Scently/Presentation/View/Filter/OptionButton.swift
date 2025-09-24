//
//  OptionButton.swift
//  Scently
//
//  Created by 임재현 on 5/25/25.
//

import UIKit
import SnapKit

final class OptionButton: UIButton {
    
    private var currentFont: UIFont = .pretendard(.regular, size: 11)
    private var normalTextColor: UIColor = .gray3
    private var selectedTextColor: UIColor = .white
  
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
        label.textAlignment = .center
        label.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        label.setContentCompressionResistancePriority(.defaultHigh, for: .horizontal)
        return label
    }()
    
    init(borderColor: UIColor = .lightgray,cornerRadius:CGFloat = 8,title: String,hasImage:Bool = false,image:String? = nil) {
        super.init(frame: .zero)

        buttonTitle.text = title
        layer.cornerRadius = cornerRadius
        backgroundColor = .gray4
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
                $0.leading.equalToSuperview().offset(14)
                $0.centerY.equalToSuperview()
                $0.size.equalTo(12)
            }

            buttonTitle.snp.makeConstraints {
                $0.leading.equalTo(iconImageView.snp.trailing).offset(6)
                $0.centerY.equalToSuperview()
                $0.top.bottom.equalToSuperview().inset(4)
                $0.trailing.equalToSuperview().inset(14)
            }

        } else {
            self.addSubview(buttonTitle)

            buttonTitle.snp.makeConstraints {
                $0.edges.equalToSuperview().inset(UIEdgeInsets(top: 3, left: 14, bottom: 3, right: 14))
            }
        }
    }
    
    func configure(with text: String) {
        buttonTitle.text = text
    }
}

extension OptionButton {
    func updateSelectedState(isSelected: Bool) {
        UIView.animate(withDuration: 0.2) {
            if isSelected {
                self.buttonTitle.textColor = .white
                self.buttonTitle.font = self.currentFont
                self.backgroundColor = .black
            } else {
                self.buttonTitle.textColor = .gray3
                self.buttonTitle.font = self.currentFont
                self.backgroundColor = .gray4
            }
            
            self.layoutIfNeeded()
            self.setNeedsDisplay()
        }
    }
    
    func configure(font: UIFont? = nil, textColor: UIColor? = nil) {
        if let font = font {
            self.currentFont = font
            buttonTitle.font = font
        }
        if let textColor = textColor {
            self.normalTextColor = textColor
            buttonTitle.textColor = textColor
        }
    }
    
}
