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
        dataSourceVC = [OOTDViewController(),
                        OOTDViewController(),
                        OOTDViewController()]
    }
}
