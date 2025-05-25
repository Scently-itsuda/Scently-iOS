//
//  CheckButton.swift
//  Scently
//
//  Created by 임재현 on 5/25/25.
//

import UIKit


final class CheckButton: UIButton {
    var buttonState: Bool = false

    init(title: String) {
        var config = UIButton.Configuration.plain()
        config.image = UIImage(named: "Rectangle 1203")
        config.title = "선택됨"
        config.imagePlacement = .leading
        config.imagePadding = 10
        config.titleAlignment = .leading
        config.background.backgroundColor = .clear
        config.background.strokeColor = .clear
        config.background.strokeWidth = 0

        super.init(frame: .zero)
        self.configuration = config

        self.configurationUpdateHandler = { [weak self] button in
            guard let self = self else { return }
            var newConfig = button.configuration ?? UIButton.Configuration.plain()

            print("isSelected: \(buttonState)")

            newConfig.image = buttonState ? UIImage(named: "Group 10") : UIImage(named: "Rectangle 1203")
            newConfig.title = buttonState ? title : title
            newConfig.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                var outgoing = incoming
                outgoing.font = UIFont.pretendard(self.buttonState ? .bold : .regular, size: 12)
                outgoing.foregroundColor = self.buttonState ? .black : .lightGray
//                
                return outgoing
            }

            button.configuration = newConfig
            self.contentHorizontalAlignment = .leading
        }

        self.addTarget(self, action: #selector(didTap), for: .touchUpInside)
        self.adjustsImageWhenHighlighted = false
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    @objc private func didTap() {
        buttonState.toggle()
    }
}

