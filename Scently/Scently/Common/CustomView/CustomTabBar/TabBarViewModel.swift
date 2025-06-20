//
//  TabBarViewModel.swift
//  Scently
//
//  Created by sy0201 on 5/21/25.
//

import Foundation
import UIKit

final class TabBarViewModel {
    let socialTabbarList = ["OOTD", "자유게시판", "리뷰보기"]  // TODO: 데이터로 교체 필요
    var dataSourceVC: [UIViewController] = []
    
    func setupViewControllers() {
        /**
         var i = 0
         socialTabbarList.forEach { _ in
         let vc = UIViewController()
         let red = CGFloat(arc4random_uniform(256)) / 255
         let green = CGFloat(arc4random_uniform(256)) / 255
         let blue = CGFloat(arc4random_uniform(256)) / 255
         
         vc.view.backgroundColor = UIColor(red: red, green: green, blue: blue, alpha: 1)
         
         let label = UILabel()
         label.text = "\(i)"
         label.font = .systemFont(ofSize: 56, weight: .bold)
         i += 1
         
         vc.view.addSubview(label)
         label.snp.makeConstraints { make in
         make.center.equalToSuperview()
         }
         dataSourceVC += [vc]
         */
        dataSourceVC = [OOTDViewController(),
                        OOTDViewController(),
                        OOTDViewController()]
    }
}
