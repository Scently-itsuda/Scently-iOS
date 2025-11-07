//
//  BulletPointLabel.swift
//  Scently
//
//  Created by 임재현 on 6/16/25.
//

import UIKit

class BulletPointLabel: UILabel {
    
    func setBulletPoints(_ items: [String], bulletSymbol: String = "•",itemSpacing: CGFloat = 8.0) {
        let paragraphStyle = NSMutableParagraphStyle()
        
        let bulletWidth = (bulletSymbol + " ").size(withAttributes: [.font: self.font!]).width
        
        paragraphStyle.firstLineHeadIndent = 0
        paragraphStyle.headIndent = bulletWidth
        
        paragraphStyle.paragraphSpacing = itemSpacing
        let attributedString = NSMutableAttributedString()
        
        for (index, item) in items.enumerated() {
            let bulletText = "\(bulletSymbol) \(item)"
            let itemAttributedString = NSMutableAttributedString(
                string: bulletText,
                attributes: [
                    .font: self.font!,
                    .paragraphStyle: paragraphStyle
                ]
            )
            
            attributedString.append(itemAttributedString)
            
            if index < items.count - 1 {
                attributedString.append(NSAttributedString(string: "\n"))
            }
        }
        
        self.attributedText = attributedString
        self.numberOfLines = 0
    }
}
