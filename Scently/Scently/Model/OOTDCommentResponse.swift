//
//  OOTDCommentResponse.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import Foundation

typealias OOTDCommentResponse = BaseResponse<CommentData>
typealias CommentResponse = BaseResponse<CommentData>

// MARK: - Comment Response 모델

// MARK: - Comment 데이터
struct CommentData: Codable {
    let commentInfos: [CommentInfo]
    let totalCommentCount: Int
}

// MARK: - Comment Info (댓글)
struct CommentInfo: Codable {
    let commentId: Int
    let userId: Int
    let profileImageUrl: String
    let createdAt: String
    let content: String
    let likeCount: Int
    let commentCount: Int
    let childCommentInfos: [ChildCommentInfo]
}

// MARK: - Child Comment Info (대댓글)
struct ChildCommentInfo: Codable {
    let commentId: Int
    let userId: Int
    let profileImageUrl: String
    let createdAt: String
    let content: String
    let likeCount: Int
}

extension CommentData {
    static func empty() -> CommentData {
        return CommentData(commentInfos: [], totalCommentCount: 0)
    }
}

//extension CommentResponse {
//    static let mockData = CommentResponse(
//        result: "SUCCESS",
//        data: CommentData(
//            commentInfos: [
//                CommentInfo(
//                    commentId: 1,
//                    userId: 101,
//                    profileImageUrl: "https://example.com/profile1.jpg",
//                    createdAt: "2025-08-10T08:30:00.000Z",
//                    content: "정말 예쁜 코디네요! 향수까지 완벽해요 ✨",
//                    likeCount: 24,
//                    commentCount: 3,
//                    childCommentInfos: [
//                        ChildCommentInfo(
//                            commentId: 11,
//                            userId: 201,
//                            profileImageUrl: "https://example.com/profile2.jpg",
//                            createdAt: "2025-08-10T08:45:00.000Z",
//                            content: "저도 그 향수 써봤는데 진짜 좋아요!",
//                            likeCount: 8
//                        ),
//                        ChildCommentInfo(
//                            commentId: 12,
//                            userId: 301,
//                            profileImageUrl: "https://example.com/profile3.jpg",
//                            createdAt: "2025-08-10T09:00:00.000Z",
//                            content: "어디서 구매하셨나요?",
//                            likeCount: 2
//                        )
//                    ]
//                ),
//                
//                CommentInfo(
//                    commentId: 2,
//                    userId: 102,
//                    profileImageUrl: "https://example.com/profile4.jpg",
//                    createdAt: "2025-08-10T07:15:00.000Z",
//                    content: "OOTD 참고할게요! 스타일링 센스가 너무 좋으시네요 👍",
//                    likeCount: 15,
//                    commentCount: 1,
//                    childCommentInfos: [
//                        ChildCommentInfo(
//                            commentId: 21,
//                            userId: 401,
//                            profileImageUrl: "https://example.com/profile5.jpg",
//                            createdAt: "2025-08-10T07:30:00.000Z",
//                            content: "동감이에요! 저도 따라해보고 싶어요",
//                            likeCount: 5
//                        )
//                    ]
//                ),
//                
//                CommentInfo(
//                    commentId: 3,
//                    userId: 103,
//                    profileImageUrl: "https://example.com/profile6.jpg",
//                    createdAt: "2025-08-10T06:45:00.000Z",
//                    content: "미스 디올 향수 진짜 추천해요! 지속력도 좋고 향도 너무 좋아요",
//                    likeCount: 31,
//                    commentCount: 0,
//                    childCommentInfos: []
//                ),
//                
//                CommentInfo(
//                    commentId: 4,
//                    userId: 104,
//                    profileImageUrl: "https://example.com/profile7.jpg",
//                    createdAt: "2025-08-10T05:20:00.000Z",
//                    content: "와 이 조합 진짜 예뻐요 🤩 저도 이런 스타일 도전해보고 싶어요",
//                    likeCount: 18,
//                    commentCount: 2,
//                    childCommentInfos: [
//                        ChildCommentInfo(
//                            commentId: 41,
//                            userId: 501,
//                            profileImageUrl: "https://example.com/profile8.jpg",
//                            createdAt: "2025-08-10T05:35:00.000Z",
//                            content: "같이 쇼핑 가요!",
//                            likeCount: 3
//                        )
//                    ]
//                ),
//                
//                CommentInfo(
//                    commentId: 5,
//                    userId: 105,
//                    profileImageUrl: "https://example.com/profile9.jpg",
//                    createdAt: "2025-08-10T04:10:00.000Z",
//                    content: "혹시 다른 향수 추천도 해주실 수 있나요? 이런 스타일 좋아해요!",
//                    likeCount: 12,
//                    commentCount: 1,
//                    childCommentInfos: [
//                        ChildCommentInfo(
//                            commentId: 51,
//                            userId: 106,
//                            profileImageUrl: "https://example.com/profile10.jpg",
//                            createdAt: "2025-08-10T04:25:00.000Z",
//                            content: "샤넬 넘버5도 추천드려요!",
//                            likeCount: 6
//                        )
//                    ]
//                )
//            ],
//            totalCommentCount: 5
//        ),
//        error: nil,
//        message: "댓글을 성공적으로 불러왔습니다."
//    )
//}
