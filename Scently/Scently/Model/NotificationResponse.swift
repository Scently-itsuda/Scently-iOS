//
//  NotificationResponse.swift
//  Scently
//
//  Created by 임재현 on 9/17/25.
//

import Foundation

typealias NotificationResponse = BaseResponse<NotificationData>

struct NotificationData: Codable {
    let dataList: [NotificationItem]
    let pageInfo: PageInfo
}

struct NotificationItem: Codable {
    let notificationId: Int
    let title: String
    let bodyMessage: String
    let targetId: Int
    let notificationType: String
}
