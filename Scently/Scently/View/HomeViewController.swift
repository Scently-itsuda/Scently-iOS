//
//  HomeViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class HomeViewController: UIViewController {
    private let label:UILabel = {
        let label = UILabel()
        label.text = "Home"
        label.font = .pretendard(.bold, size: 24)
        label.textColor = .black
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("HomeViewController init")
        setUI()
    }
    
    func setUI() {
        view.addSubview(label)
        label.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: self.view.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: self.view.centerYAnchor)
        ])
        
    }
    
    
    
}
