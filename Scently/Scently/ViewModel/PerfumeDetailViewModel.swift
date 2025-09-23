//
//  PerfumeDetailViewModel.swift
//  Scently
//
//  Created by 임재현 on 8/3/25.
//

import Foundation
import Combine

class PerfumeDetailViewModel {
    private let repository: PerfumeRepository
    private var cancellables = Set<AnyCancellable>()
    
    private let perfumeDetailSubject = CurrentValueSubject<PerfumeDetail?, Never>(nil)
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    private let errorMessageSubject = CurrentValueSubject<String?, Never>(nil)
    
    var perfumeDetail: AnyPublisher<PerfumeDetail?, Never> {
        perfumeDetailSubject.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
    
    var errorMessage: AnyPublisher<String?, Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    
    init(repository: PerfumeRepository = DefaultPerfumeRepository()) {
        self.repository = repository
    }
    
    func loadPerfumeDetailWithMock(id: Int) {
        isLoadingSubject.send(true)
        errorMessageSubject.send(nil)
        
        // Mock 데이터를 0.5초 후에 로드 (네트워크 지연 시뮬레이션)
        DispatchQueue.main.asyncAfter(deadline: .now()) { [weak self] in
            if let mockDetail = PerfumeDetailMockData.getDetail(for: id) {
                self?.perfumeDetailSubject.send(mockDetail)
            } else {
                self?.errorMessageSubject.send("향수를 찾을 수 없습니다.")
            }
            self?.isLoadingSubject.send(false)
        }
    }
    
    
    func loadPerfumeDetail(id: Int) {
        isLoadingSubject.send(true)
        errorMessageSubject.send(nil)
        
//        repository.getPerfumeDetail(id: id)
//            .sink(
//                receiveCompletion: { [weak self] completion in
//                    self?.isLoadingSubject.send(false)
//                    if case .failure(let error) = completion {
//                        self?.errorMessageSubject.send(error.localizedDescription)
//                    }
//                },
//                receiveValue: { [weak self] perfumeDetail in
//                    self?.perfumeDetailSubject.send(perfumeDetail)
//                }
//            )
//            .store(in: &cancellables)
    }
}
