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

extension CommentResponse {
    static var mockDataList: [CommentResponse] {
        return [
            // Mock Data 0
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 1,
                            userId: 2001,
                            profileImageUrl: "https://picsum.photos/50/50?random=2001",
                            createdAt: Date().addingTimeInterval(-3600).ISO8601Format(),
                            content: "스타일 너무 좋아요! 향수 조합도 완벽하네요 ✨",
                            likeCount: 15,
                            commentCount: 2,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 11,
                                    userId: 3001,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3001",
                                    createdAt: Date().addingTimeInterval(-1800).ISO8601Format(),
                                    content: "저도 그 향수 쓰고 있어요!",
                                    likeCount: 5
                                ),
                                ChildCommentInfo(
                                    commentId: 12,
                                    userId: 3002,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3002",
                                    createdAt: Date().addingTimeInterval(-900).ISO8601Format(),
                                    content: "어디서 구매하셨나요?",
                                    likeCount: 2
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 2,
                            userId: 2002,
                            profileImageUrl: "https://picsum.photos/50/50?random=2002",
                            createdAt: Date().addingTimeInterval(-7200).ISO8601Format(),
                            content: "이 코디 진짜 예뻐요 👍",
                            likeCount: 8,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 2
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 1
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 3,
                            userId: 2003,
                            profileImageUrl: "https://picsum.photos/50/50?random=2003",
                            createdAt: Date().addingTimeInterval(-5400).ISO8601Format(),
                            content: "출근룩 참고할게요! 감사합니다 🙏",
                            likeCount: 22,
                            commentCount: 3,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 31,
                                    userId: 3003,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3003",
                                    createdAt: Date().addingTimeInterval(-3600).ISO8601Format(),
                                    content: "저도 따라해봐야겠어요",
                                    likeCount: 7
                                ),
                                ChildCommentInfo(
                                    commentId: 32,
                                    userId: 3004,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3004",
                                    createdAt: Date().addingTimeInterval(-2700).ISO8601Format(),
                                    content: "혹시 브랜드 알 수 있을까요?",
                                    likeCount: 3
                                ),
                                ChildCommentInfo(
                                    commentId: 33,
                                    userId: 3005,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3005",
                                    createdAt: Date().addingTimeInterval(-1800).ISO8601Format(),
                                    content: "너무 이쁘네요!",
                                    likeCount: 1
                                )
                            ]
                        )
                    ],
                    totalCommentCount: 1
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 2
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 4,
                            userId: 2004,
                            profileImageUrl: "https://picsum.photos/50/50?random=2004",
                            createdAt: Date().addingTimeInterval(-10800).ISO8601Format(),
                            content: "스트릿 감성 좋아요! 향수는 어떤 느낌인가요?",
                            likeCount: 31,
                            commentCount: 1,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 41,
                                    userId: 3006,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3006",
                                    createdAt: Date().addingTimeInterval(-7200).ISO8601Format(),
                                    content: "우디 계열이라고 들었어요!",
                                    likeCount: 12
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 5,
                            userId: 2005,
                            profileImageUrl: "https://picsum.photos/50/50?random=2005",
                            createdAt: Date().addingTimeInterval(-14400).ISO8601Format(),
                            content: "이 조합 완전 좋네요 🔥",
                            likeCount: 18,
                            commentCount: 0,
                            childCommentInfos: []
                        ),
                        CommentInfo(
                            commentId: 6,
                            userId: 2006,
                            profileImageUrl: "https://picsum.photos/50/50?random=2006",
                            createdAt: Date().addingTimeInterval(-18000).ISO8601Format(),
                            content: "주말에 저도 이렇게 입어봐야겠어요",
                            likeCount: 9,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 3
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 3
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 7,
                            userId: 2007,
                            profileImageUrl: "https://picsum.photos/50/50?random=2007",
                            createdAt: Date().addingTimeInterval(-21600).ISO8601Format(),
                            content: "미니멀 스타일 최고예요! 향수도 깔끔한 느낌일 것 같아요",
                            likeCount: 27,
                            commentCount: 2,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 71,
                                    userId: 3007,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3007",
                                    createdAt: Date().addingTimeInterval(-19800).ISO8601Format(),
                                    content: "Byredo 진짜 좋더라구요",
                                    likeCount: 8
                                ),
                                ChildCommentInfo(
                                    commentId: 72,
                                    userId: 3008,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3008",
                                    createdAt: Date().addingTimeInterval(-18000).ISO8601Format(),
                                    content: "저도 샀어요!",
                                    likeCount: 4
                                )
                            ]
                        )
                    ],
                    totalCommentCount: 1
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 4
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 8,
                            userId: 2008,
                            profileImageUrl: "https://picsum.photos/50/50?random=2008",
                            createdAt: Date().addingTimeInterval(-25200).ISO8601Format(),
                            content: "파스텔 톤 너무 사랑스러워요 💕 향수 추천 감사합니다!",
                            likeCount: 42,
                            commentCount: 4,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 81,
                                    userId: 3009,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3009",
                                    createdAt: Date().addingTimeInterval(-23400).ISO8601Format(),
                                    content: "봄 향수로 딱이네요!",
                                    likeCount: 11
                                ),
                                ChildCommentInfo(
                                    commentId: 82,
                                    userId: 3010,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3010",
                                    createdAt: Date().addingTimeInterval(-21600).ISO8601Format(),
                                    content: "Mon Guerlain 진짜 좋아요",
                                    likeCount: 9
                                ),
                                ChildCommentInfo(
                                    commentId: 83,
                                    userId: 3011,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3011",
                                    createdAt: Date().addingTimeInterval(-19800).ISO8601Format(),
                                    content: "저도 사고 싶어요!",
                                    likeCount: 5
                                ),
                                ChildCommentInfo(
                                    commentId: 84,
                                    userId: 3012,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3012",
                                    createdAt: Date().addingTimeInterval(-18000).ISO8601Format(),
                                    content: "플로럴 계열 좋아하시면 추천!",
                                    likeCount: 7
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 9,
                            userId: 2009,
                            profileImageUrl: "https://picsum.photos/50/50?random=2009",
                            createdAt: Date().addingTimeInterval(-28800).ISO8601Format(),
                            content: "이 코디 보고 바로 구매했어요 ㅎㅎ",
                            likeCount: 14,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 2
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 5
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 10,
                            userId: 2010,
                            profileImageUrl: "https://picsum.photos/50/50?random=2010",
                            createdAt: Date().addingTimeInterval(-32400).ISO8601Format(),
                            content: "청바지 코디 완전 데일리로 좋네요!",
                            likeCount: 19,
                            commentCount: 1,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 101,
                                    userId: 3013,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3013",
                                    createdAt: Date().addingTimeInterval(-30600).ISO8601Format(),
                                    content: "저도 이렇게 입고 다녀요!",
                                    likeCount: 6
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 11,
                            userId: 2011,
                            profileImageUrl: "https://picsum.photos/50/50?random=2011",
                            createdAt: Date().addingTimeInterval(-36000).ISO8601Format(),
                            content: "Prada 향수 괜찮나요?",
                            likeCount: 11,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 2
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 6
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 12,
                            userId: 2012,
                            profileImageUrl: "https://picsum.photos/50/50?random=2012",
                            createdAt: Date().addingTimeInterval(-39600).ISO8601Format(),
                            content: "겨울 레이어링 진짜 멋있어요! 향수 2개 레이어링한 거예요?",
                            likeCount: 36,
                            commentCount: 2,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 121,
                                    userId: 3014,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3014",
                                    createdAt: Date().addingTimeInterval(-37800).ISO8601Format(),
                                    content: "둘 다 사용하신 것 같아요",
                                    likeCount: 13
                                ),
                                ChildCommentInfo(
                                    commentId: 122,
                                    userId: 3015,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3015",
                                    createdAt: Date().addingTimeInterval(-36000).ISO8601Format(),
                                    content: "Hermès + Creed 조합 궁금해요!",
                                    likeCount: 10
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 13,
                            userId: 2013,
                            profileImageUrl: "https://picsum.photos/50/50?random=2013",
                            createdAt: Date().addingTimeInterval(-43200).ISO8601Format(),
                            content: "아우터 정보 알려주실 수 있나요?",
                            likeCount: 21,
                            commentCount: 0,
                            childCommentInfos: []
                        ),
                        CommentInfo(
                            commentId: 14,
                            userId: 2014,
                            profileImageUrl: "https://picsum.photos/50/50?random=2014",
                            createdAt: Date().addingTimeInterval(-46800).ISO8601Format(),
                            content: "레이어링 완전 고수시네요 👏",
                            likeCount: 15,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 3
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 7
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 15,
                            userId: 2015,
                            profileImageUrl: "https://picsum.photos/50/50?random=2015",
                            createdAt: Date().addingTimeInterval(-50400).ISO8601Format(),
                            content: "여름 휴가 준비중인데 참고할게요! 🏖️",
                            likeCount: 24,
                            commentCount: 1,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 151,
                                    userId: 3016,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3016",
                                    createdAt: Date().addingTimeInterval(-48600).ISO8601Format(),
                                    content: "Acqua di Parma 여름에 딱이죠!",
                                    likeCount: 9
                                )
                            ]
                        )
                    ],
                    totalCommentCount: 1
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 8
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 16,
                            userId: 2016,
                            profileImageUrl: "https://picsum.photos/50/50?random=2016",
                            createdAt: Date().addingTimeInterval(-54000).ISO8601Format(),
                            content: "드레스 코디 완전 럭셔리해요! 특별한 날 참고하겠습니다 ✨",
                            likeCount: 52,
                            commentCount: 3,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 161,
                                    userId: 3017,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3017",
                                    createdAt: Date().addingTimeInterval(-52200).ISO8601Format(),
                                    content: "Black Opium 정말 좋아요!",
                                    likeCount: 17
                                ),
                                ChildCommentInfo(
                                    commentId: 162,
                                    userId: 3018,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3018",
                                    createdAt: Date().addingTimeInterval(-50400).ISO8601Format(),
                                    content: "드레스 어디 제품인가요?",
                                    likeCount: 11
                                ),
                                ChildCommentInfo(
                                    commentId: 163,
                                    userId: 3019,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3019",
                                    createdAt: Date().addingTimeInterval(-48600).ISO8601Format(),
                                    content: "저도 파티 갈 때 이렇게 입어야겠어요!",
                                    likeCount: 8
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 17,
                            userId: 2017,
                            profileImageUrl: "https://picsum.photos/50/50?random=2017",
                            createdAt: Date().addingTimeInterval(-57600).ISO8601Format(),
                            content: "YSL 향수 진짜 추천합니다 💕",
                            likeCount: 29,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 2
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            ),
            
            // Mock Data 9
            CommentResponse(
                success: true,
                data: CommentData(
                    commentInfos: [
                        CommentInfo(
                            commentId: 18,
                            userId: 2018,
                            profileImageUrl: "https://picsum.photos/50/50?random=2018",
                            createdAt: Date().addingTimeInterval(-61200).ISO8601Format(),
                            content: "애슬레저 룩 진짜 깔끔하네요! 향수도 상큼한 느낌일 것 같아요",
                            likeCount: 33,
                            commentCount: 2,
                            childCommentInfos: [
                                ChildCommentInfo(
                                    commentId: 181,
                                    userId: 3020,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3020",
                                    createdAt: Date().addingTimeInterval(-59400).ISO8601Format(),
                                    content: "Lazy Sunday Morning 진짜 좋더라구요",
                                    likeCount: 14
                                ),
                                ChildCommentInfo(
                                    commentId: 182,
                                    userId: 3021,
                                    profileImageUrl: "https://picsum.photos/50/50?random=3021",
                                    createdAt: Date().addingTimeInterval(-57600).ISO8601Format(),
                                    content: "운동 후에 딱이네요!",
                                    likeCount: 6
                                )
                            ]
                        ),
                        CommentInfo(
                            commentId: 19,
                            userId: 2019,
                            profileImageUrl: "https://picsum.photos/50/50?random=2019",
                            createdAt: Date().addingTimeInterval(-64800).ISO8601Format(),
                            content: "Maison Margiela 향수 써보고 싶어요",
                            likeCount: 16,
                            commentCount: 0,
                            childCommentInfos: []
                        ),
                        CommentInfo(
                            commentId: 20,
                            userId: 2020,
                            profileImageUrl: "https://picsum.photos/50/50?random=2020",
                            createdAt: Date().addingTimeInterval(-68400).ISO8601Format(),
                            content: "스포티한 스타일 멋있어요 🏃‍♂️",
                            likeCount: 12,
                            commentCount: 0,
                            childCommentInfos: []
                        )
                    ],
                    totalCommentCount: 3
                ),
                error: nil,
                message: "댓글을 성공적으로 불러왔습니다."
            )
        ]
    }

    static func mockData(forOOTDId ootdId: Int) -> CommentResponse? {
        guard ootdId >= 0 && ootdId < mockDataList.count else { return nil }
        return mockDataList[ootdId]
    }
}
