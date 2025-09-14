//
//  PerfumeWishlistResponse.swift
//  Scently
//
//  Created by 임재현 on 9/14/25.
//

import Foundation


typealias PerfumeWishlistResponse = BaseResponse<PerfumeWishlistData>

struct PerfumeWishlistItem: Codable {
    let perfumeId: Int
    let imageUri: String
    let brand: String
    let name: String
}


struct PerfumeWishlistData: Codable {
    let dataList: [PerfumeWishlistItem]
    let pageInfo: PageInfo
}
