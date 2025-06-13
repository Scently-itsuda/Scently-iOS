//
//  UIView+.swift
//  Scently
//
//  Created by 임재현 on 6/9/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: UIView...) {
        views.forEach { self.addSubview($0) }
    }
}
