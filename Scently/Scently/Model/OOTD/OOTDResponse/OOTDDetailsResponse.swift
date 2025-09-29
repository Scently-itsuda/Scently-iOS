//
//  OOTDDetailsResponse.swift
//  Scently
//
//  Created by 임재현 on 8/31/25.
//

import Foundation

typealias OOTDDetailResponse = BaseResponse<OOTDDetailData>

// OOTD 상세 데이터
struct OOTDDetailData: Codable {
    let ootdInfo: OOTDInfo
    let userInfo: UserInfo
    let perfumeInfo: [PerfumeInfo]
}

// OOTD 기본 정보
struct OOTDInfo: Codable {
    let ootdId: Int
    let createdAt: Date
    let ootdImageUrls: [String]
    let likeCount: Int
    let commentCount: Int
    let volume: Int
    let content: String
    let tags: [String]
    let isLiked: Bool
}

// 사용자 정보
struct UserInfo: Codable {
    let gender: String
    let age: Int
}

// 향수 정보
struct PerfumeInfo: Codable {
    let perfumeId: Int
    let perfumeBrand: String
    let perfumeImageUrl: String
    let perfumeName: String
}

extension OOTDDetailData {
    static var mockDataList: [OOTDDetailData] {
        return [
            // Mock Data 1
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 1,
                    createdAt: Date().addingTimeInterval(-86400 * 2), // 2일 전
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=1",
                        "https://picsum.photos/400/600?random=2"
                    ],
                    likeCount: 324,
                    commentCount: 45,
                    volume: 3,
                    content: "오늘 데이트룩으로 입어봤어요! 가을 느낌 물씬 나는 코디 🍂",
                    tags: ["데이트룩", "가을코디", "캐주얼"],
                    isLiked: true
                ),
                userInfo: UserInfo(gender: "여성", age: 25),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 101,
                        perfumeBrand: "Chanel",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=101",
                        perfumeName: "Coco Mademoiselle"
                    )
                ]
            ),
            
            // Mock Data 2
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 2,
                    createdAt: Date().addingTimeInterval(-86400 * 5),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=3"
                    ],
                    likeCount: 128,
                    commentCount: 23,
                    volume: 2,
                    content: "출근룩 추천! 간편하면서도 세련된 느낌 ✨",
                    tags: ["출근룩", "오피스룩", "심플"],
                    isLiked: false
                ),
                userInfo: UserInfo(gender: "여성", age: 28),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 102,
                        perfumeBrand: "Dior",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=102",
                        perfumeName: "J'adore"
                    )
                ]
            ),
            
            // Mock Data 3
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 3,
                    createdAt: Date().addingTimeInterval(-86400 * 1),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=4",
                        "https://picsum.photos/400/600?random=5",
                        "https://picsum.photos/400/600?random=6"
                    ],
                    likeCount: 567,
                    commentCount: 89,
                    volume: 4,
                    content: "주말 나들이 코디! 편하면서도 스타일리시하게 🌟",
                    tags: ["주말룩", "나들이", "스트릿"],
                    isLiked: true
                ),
                userInfo: UserInfo(gender: "남성", age: 30),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 103,
                        perfumeBrand: "Tom Ford",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=103",
                        perfumeName: "Oud Wood"
                    ),
                    PerfumeInfo(
                        perfumeId: 104,
                        perfumeBrand: "Jo Malone",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=104",
                        perfumeName: "Wood Sage & Sea Salt"
                    )
                ]
            ),
            
            // Mock Data 4
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 4,
                    createdAt: Date().addingTimeInterval(-86400 * 7),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=7"
                    ],
                    likeCount: 89,
                    commentCount: 12,
                    volume: 2,
                    content: "미니멀 무드 좋아하시는 분들께 추천! 🤍",
                    tags: ["미니멀", "모던", "블랙코디"],
                    isLiked: false
                ),
                userInfo: UserInfo(gender: "여성", age: 32),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 105,
                        perfumeBrand: "Byredo",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=105",
                        perfumeName: "Bal d'Afrique"
                    )
                ]
            ),
            
            // Mock Data 5
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 5,
                    createdAt: Date().addingTimeInterval(-86400 * 3),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=8",
                        "https://picsum.photos/400/600?random=9"
                    ],
                    likeCount: 245,
                    commentCount: 34,
                    volume: 5,
                    content: "봄 맞이 파스텔 코디 💐 향수도 화사한 플로럴로!",
                    tags: ["봄코디", "파스텔", "플로럴"],
                    isLiked: true
                ),
                userInfo: UserInfo(gender: "여성", age: 23),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 106,
                        perfumeBrand: "Guerlain",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=106",
                        perfumeName: "Mon Guerlain"
                    )
                ]
            ),
            
            // Mock Data 6
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 6,
                    createdAt: Date().addingTimeInterval(-86400 * 10),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=10"
                    ],
                    likeCount: 412,
                    commentCount: 67,
                    volume: 3,
                    content: "요즘 즐겨입는 청바지 코디! 데일리로 딱이에요 👖",
                    tags: ["데일리룩", "청바지", "캐주얼"],
                    isLiked: false
                ),
                userInfo: UserInfo(gender: "남성", age: 27),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 107,
                        perfumeBrand: "Prada",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=107",
                        perfumeName: "L'Homme Prada"
                    )
                ]
            ),
            
            // Mock Data 7
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 7,
                    createdAt: Date().addingTimeInterval(-86400 * 4),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=11",
                        "https://picsum.photos/400/600?random=12",
                        "https://picsum.photos/400/600?random=13"
                    ],
                    likeCount: 678,
                    commentCount: 102,
                    volume: 4,
                    content: "겨울 레이어링 완성! 따뜻하면서도 멋스럽게 ❄️",
                    tags: ["겨울코디", "레이어링", "아우터"],
                    isLiked: true
                ),
                userInfo: UserInfo(gender: "남성", age: 29),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 108,
                        perfumeBrand: "Hermès",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=108",
                        perfumeName: "Terre d'Hermès"
                    ),
                    PerfumeInfo(
                        perfumeId: 109,
                        perfumeBrand: "Creed",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=109",
                        perfumeName: "Aventus"
                    )
                ]
            ),
            
            // Mock Data 8
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 8,
                    createdAt: Date().addingTimeInterval(-86400 * 6),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=14"
                    ],
                    likeCount: 156,
                    commentCount: 28,
                    volume: 2,
                    content: "여름 휴가룩! 시원하고 편안한 코디 🏖️",
                    tags: ["휴가룩", "여름", "리조트"],
                    isLiked: false
                ),
                userInfo: UserInfo(gender: "여성", age: 26),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 110,
                        perfumeBrand: "Acqua di Parma",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=110",
                        perfumeName: "Colonia"
                    )
                ]
            ),
            
            // Mock Data 9
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 9,
                    createdAt: Date().addingTimeInterval(-86400 * 8),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=15",
                        "https://picsum.photos/400/600?random=16"
                    ],
                    likeCount: 934,
                    commentCount: 145,
                    volume: 5,
                    content: "특별한 날을 위한 드레스 코디 👗✨ 향수도 화려하게!",
                    tags: ["드레스", "파티룩", "특별한날"],
                    isLiked: true
                ),
                userInfo: UserInfo(gender: "여성", age: 24),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 111,
                        perfumeBrand: "Yves Saint Laurent",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=111",
                        perfumeName: "Black Opium"
                    )
                ]
            ),
            
            // Mock Data 10
            OOTDDetailData(
                ootdInfo: OOTDInfo(
                    ootdId: 0,
                    createdAt: Date().addingTimeInterval(-86400 * 9),
                    ootdImageUrls: [
                        "https://picsum.photos/400/600?random=17"
                    ],
                    likeCount: 203,
                    commentCount: 41,
                    volume: 3,
                    content: "운동 후 간단한 외출 룩! 스포티하면서도 깔끔하게 🏃‍♂️",
                    tags: ["스포티", "애슬레저", "운동후"],
                    isLiked: false
                ),
                userInfo: UserInfo(gender: "남성", age: 31),
                perfumeInfo: [
                    PerfumeInfo(
                        perfumeId: 112,
                        perfumeBrand: "Maison Margiela",
                        perfumeImageUrl: "https://picsum.photos/200/200?random=112",
                        perfumeName: "Replica Lazy Sunday Morning"
                    )
                ]
            )
        ]
    }
    
    static func mockData(forOOTDId ootdId: Int) -> OOTDDetailData? {
        return mockDataList.first { $0.ootdInfo.ootdId == ootdId }
    }
}
