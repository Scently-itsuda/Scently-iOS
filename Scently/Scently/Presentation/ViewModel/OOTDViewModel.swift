//
//  OOTDViewModel.swift
//  Scently
//
//  Created by 임재현 on 9/28/25.
//

import Foundation
import Combine

class OOTDViewModel {
    private let repository: OOTDRepository
    private var cancellables = Set<AnyCancellable>()
    
    
    private let ootdListSubject = CurrentValueSubject<OOTDListData?, Never>(nil)
    
    var isLoadingSubject = CurrentValueSubject<Bool,Never>(false)
    
    private let errorMessageSubject = CurrentValueSubject<String?, Never>(nil)
    
    var ootdList: AnyPublisher<OOTDListData?, Never> {
        ootdListSubject.eraseToAnyPublisher()
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

extension OOTDViewModel {
    func getOOTDList(order: String, page: Int, size: Int) {
        isLoadingSubject.send(true)
        errorMessageSubject.send(nil)
        
        repository.getOOTDList(order: order, page: page, size: size)
            .receive(on: DispatchQueue.main)
            .sink(
                receiveCompletion: { [weak self] completion in
                    self?.isLoadingSubject.send(false)
                    if case .failure(let error) = completion {
                        self?.errorMessageSubject.send(error.localizedDescription)
                    }
                },
                receiveValue: { [weak self] response in
                    self?.ootdListSubject.send(response)
                }
            )
            .store(in: &cancellables)
    }
}
