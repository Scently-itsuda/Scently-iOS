//
//  PriceView.swift
//  Scently
//
//  Created by 임재현 on 5/7/25.
//

import UIKit
import SnapKit

final class PriceView: UIView {

    private lazy var checkButton: UIButton = {
        var configuration = UIButton.Configuration.plain()
        
        configuration.image = UIImage(named: "Rectangle 1203")
        configuration.title = "제목"
        configuration.imagePlacement = .leading
        configuration.imagePadding = 10
        configuration.background.backgroundColor = .clear
        configuration.background.strokeColor = .clear
        configuration.background.strokeWidth = 0

        configuration.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
            var outgoing = incoming
            outgoing.font = UIFont.systemFont(ofSize: 16, weight: .bold)
            outgoing.foregroundColor = UIColor.black
            return outgoing
        }
        
        configuration.titleAlignment = .leading
        
        let button = UIButton(configuration: configuration)
        

        button.configurationUpdateHandler = { button in
            var config = button.configuration
            
    
            config?.image = button.isSelected ? UIImage(named: "Group 10") : UIImage(named: "Rectangle 1203")
            
            if button.isSelected {
                config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = UIFont.systemFont(ofSize: 16, weight: .bold)
                    outgoing.foregroundColor = UIColor.red
                    return outgoing
                }
            } else {
                config?.titleTextAttributesTransformer = UIConfigurationTextAttributesTransformer { incoming in
                    var outgoing = incoming
                    outgoing.font = UIFont.systemFont(ofSize: 16, weight: .regular)
                    outgoing.foregroundColor = UIColor.black 
                    return outgoing
                }
            }
            
            config?.title = button.isSelected ? "선택됨" : "선택됨"
            
            button.configuration = config
        }
        button.adjustsImageWhenHighlighted = false
        return button
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        self.addSubview(checkButton)
        checkButton.snp.makeConstraints {
            $0.centerX.centerY.equalToSuperview()
            $0.size.equalTo(200)
        }
        checkButton.addTarget(self, action: #selector(checkButtonDidTap), for: .touchUpInside)
    }
    
    @objc func checkButtonDidTap() {
        checkButton.isSelected.toggle()
    }
}
