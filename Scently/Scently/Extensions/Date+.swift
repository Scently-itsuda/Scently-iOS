//
//  Date+.swift
//  Scently
//
//  Created by 임재현 on 9/29/25.
//

import Foundation

extension Date {
    func timeAgoString() -> String {
        let now = Date()
        let timeInterval = now.timeIntervalSince(self)
        
        let seconds = Int(timeInterval)
        let minutes = seconds / 60
        let hours = minutes / 60
        let days = hours / 24
        let weeks = days / 7
        let months = days / 30
        let years = days / 365
        
        if seconds < 60 {
            return "방금 전"
        } else if minutes < 60 {
            return "\(minutes)분 전"
        } else if hours < 24 {
            return "\(hours)시간 전"
        } else if days < 7 {
            return "\(days)일 전"
        } else if weeks < 4 {
            return "\(weeks)주 전"
        } else if months < 12 {
            return "\(months)개월 전"
        } else {
            return "\(years)년 전"
        }
    }
}
