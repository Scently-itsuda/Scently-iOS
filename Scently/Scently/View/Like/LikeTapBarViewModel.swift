//
//  LikeTapBarModel.swift
//  Scently
//
//  Created by 임재현 on 8/24/25.
//

import UIKit

final class LikeTapBarViewModel {
    let socialTabbarList = ["제품","OOTD"]
    var dataSourceVC: [UIViewController] = []
    
    func setupViewControllers() {
        dataSourceVC = [LikePerfumeViewController(),
                        LikeOOTDViewController() ]
    }
}
