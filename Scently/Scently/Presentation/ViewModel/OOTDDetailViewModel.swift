//
//  OOTDDetailViewModel.swift
//  Scently
//
//  Created by 임재현 on 9/29/25.
//

import Foundation
import Combine

class OOTDDetailViewModel {
    private let repository: OOTDRepository
    private var cancellables = Set<AnyCancellable>()
    
    private let ootdDetailSubject = CurrentValueSubject<OOTDDetailData?, Never>(nil)
    
    var isLoadingSubject = CurrentValueSubject<Bool,Never>(false)
    
    private let errorMessageSubject = CurrentValueSubject<String?, Never>(nil)
    
    var detailData: AnyPublisher<OOTDDetailData?, Never> {
        ootdDetailSubject.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool,Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
    
    var errorMessage: AnyPublisher<String?,Never> {
        errorMessageSubject.eraseToAnyPublisher()
    }
    
    
    
    
    init(repository: OOTDRepository = OOTDRepository()) {
        self.repository = repository
    }
}

extension OOTDDetailViewModel {
    func getOOTDDetails(ootdId: Int) {
        isLoadingSubject.send(true)
        errorMessageSubject.send(nil)
        
        repository.getOOTDDetail(ootdId: ootdId)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoadingSubject.send(false)
                    if case .failure(let error) = completion {
                        self?.errorMessageSubject.send(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] response in
                    self?.ootdDetailSubject.send(response)
                }
            )
            .store(in: &cancellables)
    }
    
     func loadMockData(ootdId: Int) {

        if let mockData = OOTDDetailData.mockData(forOOTDId: ootdId) {
            ootdDetailSubject.send(mockData)
        }
        
    }
}
