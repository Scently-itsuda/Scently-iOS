//
//  PerfumeMockDAta.swift
//  Scently
//
//  Created by 임재현 on 9/20/25.
//

import Foundation

struct PerfumeMockData {
    static let mockPerfumes: [Perfume] = [
        Perfume(
            perfumeId: 1,
            name: "샤넬 N°5",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.1715.jpg",
            brand: "Chanel"
        ),
        Perfume(
            perfumeId: 2,
            name: "디올 소바쥬",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.42720.jpg",
            brand: "Dior"
        ),
        Perfume(
            perfumeId: 3,
            name: "톰 포드 블랙 오키드",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.1084.jpg",
            brand: "Tom Ford"
        ),
        Perfume(
            perfumeId: 4,
            name: "조 말론 잉글리쉬 페어 앤 프리지아",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.3552.jpg",
            brand: "Jo Malone"
        ),
        Perfume(
            perfumeId: 5,
            name: "버버리 허 오드 퍼퓸",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.54709.jpg",
            brand: "Burberry"
        ),
        Perfume(
            perfumeId: 6,
            name: "입생로랑 블랙 오피움",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.31511.jpg",
            brand: "Yves Saint Laurent"
        ),
        Perfume(
            perfumeId: 7,
            name: "구찌 블룸",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.44094.jpg",
            brand: "Gucci"
        ),
        Perfume(
            perfumeId: 8,
            name: "끌로에 오드 퍼퓸",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.611.jpg",
            brand: "Chloé"
        ),
        Perfume(
            perfumeId: 9,
            name: "메종 마르지엘라 레플리카 레이지 선데이 모닝",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.63917.jpg",
            brand: "Maison Margiela"
        ),
        Perfume(
            perfumeId: 10,
            name: "딥티크 도 손",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.10264.jpg",
            brand: "Diptyque"
        ),
        Perfume(
            perfumeId: 11,
            name: "크리드 아벤투스",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.13994.jpg",
            brand: "Creed"
        ),
        Perfume(
            perfumeId: 12,
            name: "랑콤 라 비 에 벨",
            imageURL: "https://fimgs.net/mdimg/perfume/375x500.23680.jpg",
            brand: "Lancôme"
        )
    ]
}

struct PerfumeMockData2 {
    static let mockPerfumes: [Perfume] = [
        // 샤넬 (Chanel)
        Perfume(perfumeId: 1, name: "샤넬 N°5", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1715.jpg", brand: "Chanel"),
        Perfume(perfumeId: 2, name: "샤넬 코코 마드모아젤", imageURL: "https://fimgs.net/mdimg/perfume/375x500.611.jpg", brand: "Chanel"),
        Perfume(perfumeId: 3, name: "샤넬 찬스 오 땅드르", imageURL: "https://fimgs.net/mdimg/perfume/375x500.3543.jpg", brand: "Chanel"),
        Perfume(perfumeId: 4, name: "샤넬 알뤼르 옴므", imageURL: "https://fimgs.net/mdimg/perfume/375x500.2835.jpg", brand: "Chanel"),
        
        // 디올 (Dior)
        Perfume(perfumeId: 5, name: "디올 소바쥬", imageURL: "https://fimgs.net/mdimg/perfume/375x500.42720.jpg", brand: "Dior"),
        Perfume(perfumeId: 6, name: "디올 미스 디올", imageURL: "https://fimgs.net/mdimg/perfume/375x500.36120.jpg", brand: "Dior"),
        Perfume(perfumeId: 7, name: "디올 조이", imageURL: "https://fimgs.net/mdimg/perfume/375x500.48336.jpg", brand: "Dior"),
        Perfume(perfumeId: 8, name: "디올 옴므 인텐스", imageURL: "https://fimgs.net/mdimg/perfume/375x500.5753.jpg", brand: "Dior"),
        
        // 톰 포드 (Tom Ford)
        Perfume(perfumeId: 9, name: "톰 포드 블랙 오키드", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1084.jpg", brand: "Tom Ford"),
        Perfume(perfumeId: 10, name: "톰 포드 로스트 체리", imageURL: "https://fimgs.net/mdimg/perfume/375x500.32856.jpg", brand: "Tom Ford"),
        Perfume(perfumeId: 11, name: "톰 포드 우드", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1826.jpg", brand: "Tom Ford"),
        Perfume(perfumeId: 12, name: "톰 포드 네롤리 포르토피노", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1825.jpg", brand: "Tom Ford"),
        
        // 조 말론 (Jo Malone)
        Perfume(perfumeId: 13, name: "조 말론 잉글리쉬 페어 앤 프리지아", imageURL: "https://fimgs.net/mdimg/perfume/375x500.3552.jpg", brand: "Jo Malone"),
        Perfume(perfumeId: 14, name: "조 말론 우드 세이지 앤 씨 솔트", imageURL: "https://fimgs.net/mdimg/perfume/375x500.3742.jpg", brand: "Jo Malone"),
        Perfume(perfumeId: 15, name: "조 말론 라임 바질 앤 만다린", imageURL: "https://fimgs.net/mdimg/perfume/375x500.3747.jpg", brand: "Jo Malone"),
        Perfume(perfumeId: 16, name: "조 말론 피오니 앤 블러쉬 스웨이드", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1234.jpg", brand: "Jo Malone"),
        
        // 버버리 (Burberry)
        Perfume(perfumeId: 17, name: "버버리 허 오드 퍼퓸", imageURL: "https://fimgs.net/mdimg/perfume/375x500.54709.jpg", brand: "Burberry"),
        Perfume(perfumeId: 18, name: "버버리 런던", imageURL: "https://fimgs.net/mdimg/perfume/375x500.610.jpg", brand: "Burberry"),
        Perfume(perfumeId: 19, name: "버버리 브릿", imageURL: "https://fimgs.net/mdimg/perfume/375x500.2087.jpg", brand: "Burberry"),
        
        // 입생로랑 (Yves Saint Laurent)
        Perfume(perfumeId: 20, name: "입생로랑 블랙 오피움", imageURL: "https://fimgs.net/mdimg/perfume/375x500.31511.jpg", brand: "YSL"),
        Perfume(perfumeId: 21, name: "입생로랑 리브르", imageURL: "https://fimgs.net/mdimg/perfume/375x500.55272.jpg", brand: "YSL"),
        Perfume(perfumeId: 22, name: "입생로랑 와이", imageURL: "https://fimgs.net/mdimg/perfume/375x500.27188.jpg", brand: "YSL"),
        Perfume(perfumeId: 23, name: "입생로랑 몽파리", imageURL: "https://fimgs.net/mdimg/perfume/375x500.46145.jpg", brand: "YSL"),
        
        // 구찌 (Gucci)
        Perfume(perfumeId: 24, name: "구찌 블룸", imageURL: "https://fimgs.net/mdimg/perfume/375x500.44094.jpg", brand: "Gucci"),
        Perfume(perfumeId: 25, name: "구찌 길티", imageURL: "https://fimgs.net/mdimg/perfume/375x500.6917.jpg", brand: "Gucci"),
        Perfume(perfumeId: 26, name: "구찌 플로라", imageURL: "https://fimgs.net/mdimg/perfume/375x500.6916.jpg", brand: "Gucci"),
        Perfume(perfumeId: 27, name: "구찌 러쉬", imageURL: "https://fimgs.net/mdimg/perfume/375x500.3485.jpg", brand: "Gucci"),
        
        // 끌로에 (Chloé)
        Perfume(perfumeId: 28, name: "끌로에 오드 퍼퓸", imageURL: "https://fimgs.net/mdimg/perfume/375x500.611.jpg", brand: "Chloé"),
        Perfume(perfumeId: 29, name: "끌로에 러브스토리", imageURL: "https://fimgs.net/mdimg/perfume/375x500.25312.jpg", brand: "Chloé"),
        Perfume(perfumeId: 30, name: "끌로에 노마드", imageURL: "https://fimgs.net/mdimg/perfume/375x500.50469.jpg", brand: "Chloé"),
        
        // 메종 마르지엘라 (Maison Margiela)
        Perfume(perfumeId: 31, name: "메종 마르지엘라 레플리카 레이지 선데이 모닝", imageURL: "https://fimgs.net/mdimg/perfume/375x500.63917.jpg", brand: "Maison Margiela"),
        Perfume(perfumeId: 32, name: "메종 마르지엘라 레플리카 바이 더 파이어플레이스", imageURL: "https://fimgs.net/mdimg/perfume/375x500.47931.jpg", brand: "Maison Margiela"),
        Perfume(perfumeId: 33, name: "메종 마르지엘라 레플리카 재즈 클럽", imageURL: "https://fimgs.net/mdimg/perfume/375x500.16335.jpg", brand: "Maison Margiela"),
        Perfume(perfumeId: 34, name: "메종 마르지엘라 레플리카 비치 워크", imageURL: "https://fimgs.net/mdimg/perfume/375x500.26420.jpg", brand: "Maison Margiela"),
        
        // 딥티크 (Diptyque)
        Perfume(perfumeId: 35, name: "딥티크 도 손", imageURL: "https://fimgs.net/mdimg/perfume/375x500.10264.jpg", brand: "Diptyque"),
        Perfume(perfumeId: 36, name: "딥티크 탐다오", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1328.jpg", brand: "Diptyque"),
        Perfume(perfumeId: 37, name: "딥티크 필로시코스", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1329.jpg", brand: "Diptyque"),
        Perfume(perfumeId: 38, name: "딥티크 오 로즈", imageURL: "https://fimgs.net/mdimg/perfume/375x500.30730.jpg", brand: "Diptyque"),
        
        // 크리드 (Creed)
        Perfume(perfumeId: 39, name: "크리드 아벤투스", imageURL: "https://fimgs.net/mdimg/perfume/375x500.13994.jpg", brand: "Creed"),
        Perfume(perfumeId: 40, name: "크리드 실버 마운틴 워터", imageURL: "https://fimgs.net/mdimg/perfume/375x500.395.jpg", brand: "Creed"),
        Perfume(perfumeId: 41, name: "크리드 그린 아이리쉬 트위드", imageURL: "https://fimgs.net/mdimg/perfume/375x500.474.jpg", brand: "Creed"),
        
        // 랑콤 (Lancôme)
        Perfume(perfumeId: 42, name: "랑콤 라 비 에 벨", imageURL: "https://fimgs.net/mdimg/perfume/375x500.23680.jpg", brand: "Lancôme"),
        Perfume(perfumeId: 43, name: "랑콤 트레저", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1030.jpg", brand: "Lancôme"),
        Perfume(perfumeId: 44, name: "랑콤 미라클", imageURL: "https://fimgs.net/mdimg/perfume/375x500.2071.jpg", brand: "Lancôme"),
        
        // 에르메스 (Hermès)
        Perfume(perfumeId: 45, name: "에르메스 뜨웽끌", imageURL: "https://fimgs.net/mdimg/perfume/375x500.3613.jpg", brand: "Hermès"),
        Perfume(perfumeId: 46, name: "에르메스 테레 드 에르메스", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1908.jpg", brand: "Hermès"),
        Perfume(perfumeId: 47, name: "에르메스 정원 시리즈", imageURL: "https://fimgs.net/mdimg/perfume/375x500.2655.jpg", brand: "Hermès"),
        
        // 프라다 (Prada)
        Perfume(perfumeId: 48, name: "프라다 캔디", imageURL: "https://fimgs.net/mdimg/perfume/375x500.14528.jpg", brand: "Prada"),
        Perfume(perfumeId: 49, name: "프라다 라 팜므", imageURL: "https://fimgs.net/mdimg/perfume/375x500.638.jpg", brand: "Prada"),
        Perfume(perfumeId: 50, name: "프라다 루나로사", imageURL: "https://fimgs.net/mdimg/perfume/375x500.9549.jpg", brand: "Prada"),
        
        // 불가리 (Bvlgari)
        Perfume(perfumeId: 51, name: "불가리 옴니아 크리스탈린", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1881.jpg", brand: "Bvlgari"),
        Perfume(perfumeId: 52, name: "불가리 블랙", imageURL: "https://fimgs.net/mdimg/perfume/375x500.464.jpg", brand: "Bvlgari"),
        Perfume(perfumeId: 53, name: "불가리 아쿠아", imageURL: "https://fimgs.net/mdimg/perfume/375x500.638.jpg", brand: "Bvlgari"),
        
        // 돌체앤가바나 (Dolce&Gabbana)
        Perfume(perfumeId: 54, name: "돌체앤가바나 라이트 블루", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1058.jpg", brand: "D&G"),
        Perfume(perfumeId: 55, name: "돌체앤가바나 더 원", imageURL: "https://fimgs.net/mdimg/perfume/375x500.1841.jpg", brand: "D&G"),
        Perfume(perfumeId: 56, name: "돌체앤가바나 돌체", imageURL: "https://fimgs.net/mdimg/perfume/375x500.31351.jpg", brand: "D&G"),
        
        // 조르지오 아르마니 (Giorgio Armani)
        Perfume(perfumeId: 57, name: "조르지오 아르마니 시", imageURL: "https://fimgs.net/mdimg/perfume/375x500.410.jpg", brand: "Armani"),
        Perfume(perfumeId: 58, name: "조르지오 아르마니 아쿠아 디 지오", imageURL: "https://fimgs.net/mdimg/perfume/375x500.410.jpg", brand: "Armani"),
        Perfume(perfumeId: 59, name: "조르지오 아르마니 마이 웨이", imageURL: "https://fimgs.net/mdimg/perfume/375x500.56819.jpg", brand: "Armani"),
        
        // 캘빈클라인 (Calvin Klein)
        Perfume(perfumeId: 60, name: "캘빈클라인 원", imageURL: "https://fimgs.net/mdimg/perfume/375x500.218.jpg", brand: "Calvin Klein"),
        Perfume(perfumeId: 61, name: "캘빈클라인 이터니티", imageURL: "https://fimgs.net/mdimg/perfume/375x500.219.jpg", brand: "Calvin Klein"),
        Perfume(perfumeId: 62, name: "캘빈클라인 CK2", imageURL: "https://fimgs.net/mdimg/perfume/375x500.40218.jpg", brand: "Calvin Klein")
    ]
}
