//
//  DividerView.swift
//  Scently
//
//  Created by 임재현 on 4/30/25.
//

import UIKit
import SnapKit

final class DividerView: UIView {
    enum Axis {
        case horizontal, vertical
    }
    init(backgroundColor: UIColor = .lightgray, height: CGFloat = 1.0,axis:Axis = .horizontal) {
        super.init(frame: .zero)
        self.backgroundColor = backgroundColor
        
        self.snp.makeConstraints {
            switch axis {
            case .horizontal:
                $0.height.equalTo(height)
            case .vertical:
                $0.width.equalTo(height)
            }
        }
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
