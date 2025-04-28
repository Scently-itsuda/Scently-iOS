//
//  LikeViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class LikeViewController: UIViewController {
   
    private let label:UILabel = {
        let label = UILabel()
        label.text = "Like"
        label.font = .pretendard(.bold, size: 24)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("LikeViewController init")
    }
}
