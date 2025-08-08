//
//  ReuseIdentifying.swift
//  Scently
//
//  Created by sy0201 on 5/21/25.
//

import Foundation

protocol ReuseIdentifying: AnyObject {
    static var reuseIdentifier: String { get }
}

extension ReuseIdentifying {
    static var reuseIdentifier: String {
        String(describing: self)
    }
}
