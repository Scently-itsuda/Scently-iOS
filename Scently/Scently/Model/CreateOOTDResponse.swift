//
//  CreateOOTDResponse.swift
//  Scently
//
//  Created by 임재현 on 8/30/25.
//

import Foundation


typealias CreateOOTDResponse = BaseResponse<CreateOOTDData>

struct CreateOOTDData: Codable {
    let ootdId: Int
}
