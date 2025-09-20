//
//  PerfumeDetailResponse.swift
//  Scently
//
//  Created by 임재현 on 7/20/25.
//

import Foundation

// MARK: - 향수 상세 정보 Responese Model
struct PerfumeDetailResponse: Codable {
    let result: String
    let data: PerfumeDetail
    let error: String?
    let message: String
}

struct PerfumeDetail: Codable {
    let perfumeId: Int
    let imageURL: String
    let brand: String
    let name: String
    let perfumeVolumes: [PerfumeVolume]
    let potential: String
    let accords: PerfumeAccords
    let description: String
    let detail: String
}

struct PerfumeVolume: Codable {
    let id: Int
    let volume: Int
    let price: Int
}

struct PerfumeAccords: Codable {
    let topNotes: [Note]
    let middleNotes: [Note]
    let baseNotes: [Note]
    let unknownNotes: [Note]
}

struct Note: Codable {
    let id: Int
    let name: String
}

// Mock 데이터
struct PerfumeDetailMockData {
    static let mockDetails: [Int: PerfumeDetail] = [
        1: PerfumeDetail(
            perfumeId: 1,
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.1715.jpg",
            brand: "Chanel",
            name: "샤넬 N°5",
            perfumeVolumes: [
                PerfumeVolume(id: 1, volume: 50, price: 185000),
                PerfumeVolume(id: 2, volume: 100, price: 255000),
                PerfumeVolume(id: 3, volume: 200, price: 355000)
            ],
            potential: "오 드 퍼퓸",
            accords: PerfumeAccords(
                topNotes: [
                    Note(id: 1, name: "알데하이드"),
                    Note(id: 2, name: "네롤리"),
                    Note(id: 3, name: "일랑일랑")
                ],
                middleNotes: [
                    Note(id: 4, name: "자스민"),
                    Note(id: 5, name: "로즈"),
                    Note(id: 6, name: "아이리스")
                ],
                baseNotes: [
                    Note(id: 7, name: "샌달우드"),
                    Note(id: 8, name: "바닐라"),
                    Note(id: 9, name: "베티버")
                ],
                unknownNotes: []
            ),
            description: "1921년 출시된 전설적인 향수로, 마릴린 먼로가 사랑한 향수로 유명합니다.",
            detail: "세계에서 가장 유명한 향수 중 하나인 샤넬 N°5는 알데하이드 플로럴 계열의 대표작입니다. 코코 샤넬과 조향사 에르네스트 보가 함께 만든 이 향수는 우아하고 세련된 여성성을 표현합니다."
        ),
        
        2: PerfumeDetail(
            perfumeId: 2,
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.42720.jpg",
            brand: "Dior",
            name: "디올 소바쥬",
            perfumeVolumes: [
                PerfumeVolume(id: 4, volume: 60, price: 125000),
                PerfumeVolume(id: 5, volume: 100, price: 165000),
                PerfumeVolume(id: 6, volume: 200, price: 235000)
            ],
            potential: "오 드 뚜왈렛",
            accords: PerfumeAccords(
                topNotes: [
                    Note(id: 10, name: "베르가못"),
                    Note(id: 11, name: "페퍼"),
                    Note(id: 12, name: "엘레미")
                ],
                middleNotes: [
                    Note(id: 13, name: "핑크 페퍼"),
                    Note(id: 14, name: "라벤더"),
                    Note(id: 15, name: "제라늄")
                ],
                baseNotes: [
                    Note(id: 16, name: "앰브록산"),
                    Note(id: 17, name: "파출리"),
                    Note(id: 18, name: "베티버")
                ],
                unknownNotes: []
            ),
            description: "야생적이면서도 세련된 남성을 위한 시그니처 향수입니다.",
            detail: "2015년 출시된 디올 소바쥬는 프란시스 쿠르크지안이 조향한 현대적인 우디 아로마틱 향수입니다. 신선한 베르가못과 강렬한 앰브록산의 조화가 특징적입니다."
        ),
        
        3: PerfumeDetail(
            perfumeId: 3,
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.1084.jpg",
            brand: "Tom Ford",
            name: "톰 포드 블랙 오키드",
            perfumeVolumes: [
                PerfumeVolume(id: 7, volume: 50, price: 245000),
                PerfumeVolume(id: 8, volume: 100, price: 355000)
            ],
            potential: "오 드 퍼퓸",
            accords: PerfumeAccords(
                topNotes: [
                    Note(id: 19, name: "트러플"),
                    Note(id: 20, name: "베르가못"),
                    Note(id: 21, name: "일랑일랑")
                ],
                middleNotes: [
                    Note(id: 22, name: "블랙 오키드"),
                    Note(id: 23, name: "블랙 플럼"),
                    Note(id: 24, name: "로터스")
                ],
                baseNotes: [
                    Note(id: 25, name: "파출리"),
                    Note(id: 26, name: "바닐라"),
                    Note(id: 27, name: "인센스")
                ],
                unknownNotes: []
            ),
            description: "신비롭고 관능적인 블랙 오키드의 매혹적인 향기",
            detail: "톰 포드의 시그니처 향수인 블랙 오키드는 2006년 출시되었습니다. 희귀한 블랙 오키드 꽃과 다크 초콜릿, 트러플의 조화로 강렬하고 매혹적인 향을 선사합니다."
        ),
        
        4: PerfumeDetail(
            perfumeId: 4,
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.3552.jpg",
            brand: "Jo Malone",
            name: "잉글리쉬 페어 앤 프리지아",
            perfumeVolumes: [
                PerfumeVolume(id: 9, volume: 30, price: 95000),
                PerfumeVolume(id: 10, volume: 100, price: 185000)
            ],
            potential: "코롱",
            accords: PerfumeAccords(
                topNotes: [
                    Note(id: 28, name: "킹 윌리엄 배"),
                    Note(id: 29, name: "프리지아")
                ],
                middleNotes: [
                    Note(id: 30, name: "로즈"),
                    Note(id: 31, name: "패치워크")
                ],
                baseNotes: [
                    Note(id: 32, name: "앰버"),
                    Note(id: 33, name: "패추리"),
                    Note(id: 34, name: "우드")
                ],
                unknownNotes: []
            ),
            description: "싱그러운 배와 우아한 프리지아의 조화",
            detail: "조 말론의 베스트셀러 향수로, 가을에 막 수확한 윌리엄 배의 신선함과 화이트 프리지아의 섬세함이 어우러진 향입니다. 은은하면서도 세련된 향이 특징입니다."
        ),
        
        5: PerfumeDetail(
            perfumeId: 5,
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.54709.jpg",
            brand: "Burberry",
            name: "버버리 허",
            perfumeVolumes: [
                PerfumeVolume(id: 11, volume: 50, price: 125000),
                PerfumeVolume(id: 12, volume: 100, price: 165000)
            ],
            potential: "오 드 퍼퓸",
            accords: PerfumeAccords(
                topNotes: [
                    Note(id: 35, name: "블랙커런트"),
                    Note(id: 36, name: "블루베리"),
                    Note(id: 37, name: "만다린")
                ],
                middleNotes: [
                    Note(id: 38, name: "피오니"),
                    Note(id: 39, name: "재스민"),
                    Note(id: 40, name: "바이올렛")
                ],
                baseNotes: [
                    Note(id: 41, name: "패츄리"),
                    Note(id: 42, name: "로즈우드"),
                    Note(id: 43, name: "앰버")
                ],
                unknownNotes: []
            ),
            description: "현대적이고 당당한 여성을 위한 향수",
            detail: "2018년 출시된 버버리 허는 프랜시스 쿠르크지안이 조향했습니다. 런던 여성의 자유롭고 대담한 정신을 담아 과감한 베리 향과 관능적인 우디 노트가 조화를 이룹니다."
        ),
        
        6: PerfumeDetail(
            perfumeId: 6,
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.31511.jpg",
            brand: "Yves Saint Laurent",
            name: "입생로랑 블랙 오피움",
            perfumeVolumes: [
                PerfumeVolume(id: 13, volume: 30, price: 115000),
                PerfumeVolume(id: 14, volume: 50, price: 155000),
                PerfumeVolume(id: 15, volume: 90, price: 215000)
            ],
            potential: "오 드 퍼퓸",
            accords: PerfumeAccords(
                topNotes: [
                    Note(id: 44, name: "핑크 페퍼"),
                    Note(id: 45, name: "오렌지 블라썸"),
                    Note(id: 46, name: "배")
                ],
                middleNotes: [
                    Note(id: 47, name: "커피"),
                    Note(id: 48, name: "자스민"),
                    Note(id: 49, name: "비터 아몬드")
                ],
                baseNotes: [
                    Note(id: 50, name: "바닐라"),
                    Note(id: 51, name: "패츄리"),
                    Note(id: 52, name: "화이트 머스크")
                ],
                unknownNotes: [
                    Note(id: 53, name: "시크릿 노트")
                ]
            ),
            description: "강렬하고 중독적인 커피와 바닐라의 조화",
            detail: "2014년 출시된 블랙 오피움은 도발적이고 신비로운 여성을 위한 향수입니다. 강렬한 커피 노트와 달콤한 바닐라가 만나 중독적인 향을 만들어냅니다."
        )
    ]
    
    static func getDetail(for id: Int) -> PerfumeDetail? {
        return mockDetails[id]
    }
}
