//
//  LoginViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class LoginViewController: UIViewController {
    
    private let label: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.bold, size: 16)
        label.textColor = ._121212
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .deepNavy
    }
}
