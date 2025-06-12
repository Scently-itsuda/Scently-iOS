//
//  SampleModel.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import Foundation
// MARK: - 모델 정의

struct Perfume: Codable {
    let perfumeId: Int
    let name: String
    let imageURL: String
    let brand: String
}

struct PageInfo: Codable {
    let page: Int
    let size: Int
    let totalElements: Int
    let totalPages: Int
}

struct PerfumeResponse: Codable {
    let success: Bool
    let data: PerfumeData
    let error: String?
}

struct PerfumeData: Codable {
    let datalist: [Perfume]
    let pageInfo: PageInfo
}

// MARK: - Mock 데이터 생성 및 반환

class PerfumeMockService {
    
    static let shared = PerfumeMockService()
    
    private init() {}
     func fetchMockPerfumes() -> PerfumeResponse {
        let perfumes = [
            Perfume(perfumeId: 1, name: "조말론 블랙베리 앤 베이", imageURL: "Diptyque", brand: "조말론"),
            Perfume(perfumeId: 2, name: "디올 쟈도르", imageURL: "dior 향수", brand: "디올"),
            Perfume(perfumeId: 3, name: "샤넬 넘버5", imageURL: "Diptyque", brand: "샤넬"),
            Perfume(perfumeId: 4, name: "겔랑 미츠키", imageURL: "dior 향수", brand: "겔랑"),
            Perfume(perfumeId: 5, name: "랑방 에끌라 드 아르페쥬", imageURL: "Diptyque", brand: "랑방"),
            Perfume(perfumeId: 6, name: "입생로랑 몽 파리", imageURL: "dior 향수", brand: "입생로랑"),
            Perfume(perfumeId: 7, name: "버버리 허", imageURL: "Diptyque", brand: "버버리"),
            Perfume(perfumeId: 8, name: "톰포드 블랙 오키드", imageURL: "dior 향수", brand: "톰포드"),
            Perfume(perfumeId: 9, name: "에르메스 떼르 데르메스", imageURL: "Diptyque", brand: "에르메스"),
            Perfume(perfumeId: 10, name: "구찌 블룸", imageURL: "dior 향수", brand: "구찌"),
            Perfume(perfumeId: 11, name: "크리드 어벤투스", imageURL: "Diptyque", brand: "크리드"),
            Perfume(perfumeId: 12, name: "랑콤 라 비 에 벨", imageURL: "dior 향수", brand: "랑콤"),
            Perfume(perfumeId: 13, name: "캘빈클라인 이터너티", imageURL: "Diptyque", brand: "캘빈클라인"),
            Perfume(perfumeId: 14, name: "조르지오 아르마니 시", imageURL: "dior 향수", brand: "아르마니"),
            Perfume(perfumeId: 15, name: "비비안웨스트우드 부케", imageURL: "Diptyque", brand: "비비안웨스트우드"),
            Perfume(perfumeId: 16, name: "마크제이콥스 데이지", imageURL: "dior 향수", brand: "마크제이콥스"),
            Perfume(perfumeId: 17, name: "끌로에 끌로에", imageURL: "Diptyque", brand: "끌로에"),
            Perfume(perfumeId: 18, name: "불가리 옴니아", imageURL: "dior 향수", brand: "불가리"),
            Perfume(perfumeId: 19, name: "겐조 플라워 바이 겐조", imageURL: "Diptyque", brand: "겐조"),
            Perfume(perfumeId: 20, name: "조말론 라임 바질 앤 만다린", imageURL: "dior 향수", brand: "조말론")
        ]
        
        let pageInfo = PageInfo(page: 1, size: 20, totalElements: 100, totalPages: 5)
        let data = PerfumeData(datalist: perfumes, pageInfo: pageInfo)
        
        return PerfumeResponse(success: true, data: data, error: nil)
    }
}
