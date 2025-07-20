//
//  UIView+.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit

extension UIView {
    func addSubviews(_ views: [UIView]) {
        views.forEach { self.addSubview($0) }
    }
}
