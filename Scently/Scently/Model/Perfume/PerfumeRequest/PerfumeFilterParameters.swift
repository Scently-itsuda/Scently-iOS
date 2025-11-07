//
//  PerfumeFilterParameters.swift
//  Scently
//
//  Created by 임재현 on 9/20/25.
//

import Foundation

struct PerfumeFilterParameters {
    var minPrice: String?
    var maxPrice: String?
    var genders: String?
    var accords: String?
    var potential: String?
    var brands: String?
    var countires: String?
    
    func toDictionary() -> [String: String] {
        var params: [String: String] = [:]
        
        if let minPrice = minPrice { params["minPrice"] = minPrice}
        if let maxPrice = maxPrice { params["maxPrice"] = maxPrice}
        if let genders = genders { params["genders"] = genders}
        if let accords = accords { params["accords"] = accords}
        if let potential = potential { params["potential"] = potential}
        if let brands = brands { params["brands"] = brands}
        if let countires = countires { params["countires"] = countires}
        
        return params
    }
}
