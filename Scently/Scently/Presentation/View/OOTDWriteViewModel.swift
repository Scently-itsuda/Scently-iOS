//
//  OOTDWriteViewModel.swift
//  Scently
//
//  Created by 임재현 on 11/14/25.
//

import UIKit
import Photos
import Combine

class OOTDWriteViewModel {
    
    enum PhotoPermissionStatus {
        case authorized
        case denied
        case notDetermined
    }
    
    private let permissionStatusSubject = CurrentValueSubject<PhotoPermissionStatus, Never>(.notDetermined)
    private let selectedImagesSubject = CurrentValueSubject<[UIImage], Never>([])
    private let isLoadingSubject = CurrentValueSubject<Bool, Never>(false)
    
    var permissionStatus: AnyPublisher<PhotoPermissionStatus, Never> {
        permissionStatusSubject.eraseToAnyPublisher()
    }
    
    var selectedImages: AnyPublisher<[UIImage], Never> {
        selectedImagesSubject.eraseToAnyPublisher()
    }
    
    var isLoading: AnyPublisher<Bool, Never> {
        isLoadingSubject.eraseToAnyPublisher()
    }
    
    private let maxImageCount = 5
    
    func setInitialImages(_ images: [UIImage]) {
        let limitedImages = Array(images.prefix(maxImageCount))
        selectedImagesSubject.send(limitedImages)
    }
    
    func checkPhotoPermission() {
        let status = PHPhotoLibrary.authorizationStatus(for: .readWrite)
        
        switch status {
        case .authorized, .limited:
            permissionStatusSubject.send(.authorized)
            
        case .notDetermined:
            PHPhotoLibrary.requestAuthorization(for: .readWrite) { [weak self] newStatus in
                DispatchQueue.main.async {
                    if newStatus == .authorized || newStatus == .limited {
                        self?.permissionStatusSubject.send(.authorized)
                    } else {
                        self?.permissionStatusSubject.send(.denied)
                    }
                }
            }
            
        case .denied, .restricted:
            permissionStatusSubject.send(.denied)
            
        @unknown default:
            permissionStatusSubject.send(.denied)
        }
    }
    
    func addImage(_ image: UIImage) {
        var current = selectedImagesSubject.value
        guard current.count < maxImageCount else { return }
        current.append(image)
        selectedImagesSubject.send(current)
    }
    
    func removeImage(at index: Int) {
        var current = selectedImagesSubject.value
        guard index < current.count else { return }
        current.remove(at: index)
        selectedImagesSubject.send(current)
    }
    
    func canAddMoreImages() -> Bool {
        return selectedImagesSubject.value.count < maxImageCount
    }
    
    func remainingImageCount() -> Int {
        return maxImageCount - selectedImagesSubject.value.count
    }
    
    func getSelectedImagesValue() -> [UIImage] {
        return selectedImagesSubject.value
    }
}
