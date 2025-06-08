//
//  FilterData.swift
//  Scently
//
//  Created by 임재현 on 6/7/25.
//

import Foundation

struct FilterData {
    var selectedGender: GenderView.Gender?
    var selectedPrice: String?
    var minPrice: String?
    var maxPrice: String?
    var selectedAccords: [String]
    var selectedBrands: [String]
    var selectedConcentration: [String]
    var selectedNations: [String]
    var isNewProduct: Bool
    
    init() {
        selectedGender = nil
        selectedPrice = nil
        minPrice = nil
        maxPrice = nil
        selectedAccords = []
        selectedBrands = []
        selectedConcentration = []
        selectedNations = []
        isNewProduct = false
    }
}
