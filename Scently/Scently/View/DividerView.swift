//
//  DividerView.swift
//  Scently
//
//  Created by 임재현 on 4/30/25.
//

import UIKit
import SnapKit

final class DividerView: UIView {
    init(backgroundColor: UIColor = .lightgray, height: CGFloat = 1.0) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        snp.makeConstraints {
            $0.height.equalTo(height)
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
