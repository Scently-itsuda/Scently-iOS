//
//  OOTDCommentViewController.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class OOTDCommentViewController: UIViewController {
   
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
    }
}

extension OOTDCommentViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
    }
    private func setupConstraints() {}
}
