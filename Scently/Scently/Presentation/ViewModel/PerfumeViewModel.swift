//
//  PerfumeViewModel.swift
//  Scently
//
//  Created by 임재현 on 7/21/25.
//

import Foundation
import Combine

class PerfumeViewModel {
    private let repository: PerfumeRepository
    private var cancellables = Set<AnyCancellable>()
    
    @Published var _perfumes: [Perfume] = []
    @Published var _isLoading: Bool = false
    @Published var _errorMessage: String?
    
    var perfumes: AnyPublisher<[Perfume], Never> {
        $_perfumes.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool,Never> {
        $_isLoading.eraseToAnyPublisher()
    }
    
    var errorMessage: AnyPublisher<String?,Never> {
        $_errorMessage.eraseToAnyPublisher()
    }
    
    init(repository: PerfumeRepository = DefaultPerfumeRepository()) {
        self.repository = repository
    }
    
    func loadPerfumes(with filters: PerfumeFilterParameters? = nil) {
        _isLoading = true
        _errorMessage = nil
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 0.5) { [weak self] in
//            self?._perfumes = PerfumeMockData.mockPerfumes
//            self?._isLoading = false
//        }
        
        repository.getPerfumes(filters: filters)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?._isLoading = false
                    if case .failure(let error) = completion {
                        self?._errorMessage = error.localizedDescription
                    }
                }, receiveValue: { [weak self] perfumes in
                    self?._perfumes = perfumes
                }
            )
            .store(in: &cancellables)
    }
}
