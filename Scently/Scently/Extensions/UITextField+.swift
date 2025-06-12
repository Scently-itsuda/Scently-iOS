//
//  UITextField+.swift
//  Scently
//
//  Created by 임재현 on 5/25/25.
//

import UIKit

extension UITextField {
    func configureDefaultTextField() {
        self.autocorrectionType = .no
        self.spellCheckingType = .no
        self.autocapitalizationType = .none
        self.clearButtonMode = .always
        self.clearsOnBeginEditing = false
    }
    
    func addLeftView(_ padding: CGFloat = 16) {
        let leftView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height:  self.bounds.height))
        self.leftView = leftView
        self.leftViewMode = .always
    }
    
    func addRightView(_ padding: CGFloat = 16) {
        let rightView = UIView(frame: CGRect(x: 0, y: 0, width: padding, height: self.bounds.height))
        self.rightView = rightView
        self.rightViewMode = .always
    }
    
    func addRightLabel(_ text: String, font: UIFont = .pretendard(.regular, size: 12), padding: CGFloat = 8) {
        let label = UILabel()
        label.text = text
        label.font = font
        label.textColor = .gray
        label.sizeToFit()

        let container = UIView(
            frame: CGRect(x: 0, y: 0, width: label.frame.width + padding, height: label.frame.height)
        )
        label.frame.origin = .zero
        container.addSubview(label)

        self.rightView = container
        self.rightViewMode = .always
    }
}
