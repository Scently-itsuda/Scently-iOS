//
//  OOTDWriteData.swift
//  Scently
//
//  Created by 임재현 on 11/19/25.
//

import UIKit

struct OOTDWriteData {
    var images: [UIImage]
    var content: String
    var hashtags: [String]
    var products: [Product]
    
    init() {
        self.images = []
        self.content = ""
        self.hashtags = []
        self.products = []
    }
}

struct Product {
    let id: String
    let name: String
    let brand: String
    let imageURL: String?
}
