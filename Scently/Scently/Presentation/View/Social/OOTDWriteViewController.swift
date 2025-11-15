//
//  OOTDWriteViewController.swift
//  Scently
//
//  Created by 임재현 on 11/14/25.
//

import UIKit
import Photos
import PhotosUI
import Combine
import SnapKit

final class OOTDWriteViewController: UIViewController {
    
    private let viewModel = OOTDWriteViewModel()
    private var cancellables = Set<AnyCancellable>()
    
    private let navigationBar: UIView = {
       let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    private var backButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(backButtonDidTap), for: .touchUpInside)
        return button
    }()
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "OOTD"
        label.font = .pretendard(.bold, size: 17)
        label.textAlignment = .center
        label.textColor = .black
        return label
    }()
    
    private lazy var nextButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("다음", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .medium)
        button.tintColor = .systemBlue
        button.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let separatorLine: UIView = {
        let view = UIView()
        view.backgroundColor = .lightGray
        return view
    }()
    
    private lazy var selectPhotoButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("사진 추가", for: .normal)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 8
        button.addTarget(self, action: #selector(selectPhotoButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private lazy var photoCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 80, height: 80)
        layout.minimumInteritemSpacing = 8
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.layer.cornerRadius = 8
        cv.showsHorizontalScrollIndicator = false
        return cv
    }()
    
    private let contentTextView: UITextView = {
        let tv = UITextView()
        tv.font = .systemFont(ofSize: 16)
        tv.textColor = .black
        tv.backgroundColor = .white
        tv.layer.cornerRadius = 8
        tv.textContainerInset = UIEdgeInsets(top: 12, left: 12, bottom: 12, right: 12)
        return tv
    }()
    
    private let placeholderLabel: UILabel = {
        let label = UILabel()
        label.text = "내용을 입력하세요"
        label.font = .systemFont(ofSize: 16)
        label.textColor = .systemGray3
        return label
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupCollectionView()
        setupTextView()
        setupKeyboard()
        bindViewModel()
    }
    
    func configure(with images: [UIImage]) {
        viewModel.setInitialImages(images)
    }
    
    private func setupUI() {
        view.addSubviews(navigationBar,selectPhotoButton,photoCollectionView,separatorLine,contentTextView)
        navigationBar.addSubviews(backButton,titleLabel,nextButton)
        
        contentTextView.addSubview(placeholderLabel)
        
        contentTextView.backgroundColor = .lightGray
    }
    
    private func setupConstraints() {
        
        navigationBar.snp.makeConstraints {
             $0.top.equalTo(view.safeAreaLayoutGuide)
             $0.leading.trailing.equalToSuperview()
             $0.height.equalTo(44)
         }
         
         backButton.snp.makeConstraints {
             $0.leading.equalToSuperview().offset(16)
             $0.centerY.equalToSuperview()
             $0.width.height.equalTo(44)
         }
         
         titleLabel.snp.makeConstraints {
             $0.center.equalToSuperview()
         }
         
         nextButton.snp.makeConstraints {
             $0.trailing.equalToSuperview().offset(-16)
             $0.centerY.equalToSuperview()
         }
         
        separatorLine.snp.makeConstraints {
            $0.top.equalTo(navigationBar.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(1)
        }
        
        photoCollectionView.snp.makeConstraints {
            $0.top.equalTo(separatorLine.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(90)
        }
        
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview().inset(24)
            $0.height.equalTo(150)
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(12)
            $0.leading.equalToSuperview().offset(16)
        }
        
        selectPhotoButton.snp.makeConstraints {
            $0.top.equalTo(photoCollectionView.snp.bottom).offset(40)
            $0.centerX.equalToSuperview()
            $0.width.equalTo(200)
            $0.height.equalTo(50)
        }
        
    }
    
    private func setupCollectionView() {
        photoCollectionView.dataSource = self
        photoCollectionView.delegate = self
        photoCollectionView.register(PhotoCell.self, forCellWithReuseIdentifier: "PhotoCell")
    }
    
    private func setupTextView() {
        contentTextView.delegate = self
    }
    
    private func setupKeyboard() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        // 이미지 추가 버튼
        let addPhotoButton = UIBarButtonItem(
            image: UIImage(systemName: "photo"),
            style: .plain,
            target: self,
            action: #selector(selectPhotoButtonTapped)
        )
        
        // 태그 입력 버튼
        let hashtagButton = UIBarButtonItem(
            title: "#태그입력",
            style: .plain,
            target: self,
            action: #selector(hashtagButtonTapped)
        )
        
        let fixedSpace = UIBarButtonItem(barButtonSystemItem: .fixedSpace, target: nil, action: nil)
        fixedSpace.width = 16
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(title: "완료", style: .done, target: self, action: #selector(dismissKeyboard))
        
        toolbar.items = [
            addPhotoButton,
            fixedSpace,
            hashtagButton,
            flexSpace,
            doneButton
        ]
        
        contentTextView.inputAccessoryView = toolbar
    }
    
    @objc private func hashtagButtonTapped() {
        showHashtagBottomSheet()
    }

    private func showHashtagBottomSheet() {
        let bottomSheet = HashtagBottomSheetViewController()
        bottomSheet.onHashtagSelected = { [weak self] hashtags in
            // 선택된 태그를 contentTextView에 추가
            let currentText = self?.contentTextView.text ?? ""
            let hashtagText = hashtags.map { "#\($0)" }.joined(separator: " ")
            self?.contentTextView.text = currentText + " " + hashtagText
            self?.placeholderLabel.isHidden = true
        }
        
        if let sheet = bottomSheet.sheetPresentationController {
            sheet.detents = [.medium(), .large()]
            sheet.prefersGrabberVisible = true
        }
        
        present(bottomSheet, animated: true)
    }
    
    private func bindViewModel() {
        viewModel.selectedImages
            .receive(on: DispatchQueue.main)
            .sink { [weak self] _ in
                self?.photoCollectionView.reloadData()
            }
            .store(in: &cancellables)
        
        viewModel.permissionStatus
            .receive(on: DispatchQueue.main)
            .sink { [weak self] status in
                switch status {
                case .authorized:
                    self?.presentPhotoPicker()
                case .denied:
                    self?.showPermissionDeniedAlert()
                case .notDetermined:
                    break
                }
            }
            .store(in: &cancellables)
    }
    
    @objc private func backButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc private func nextButtonTapped() {
        print("다음 버튼 클릭")
    }
    
    @objc private func selectPhotoButtonTapped() {
        guard viewModel.canAddMoreImages() else {
            showMaxImagesAlert()
            return
        }
        
        viewModel.checkPhotoPermission()
    }
    
    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
    
    private func presentPhotoPicker() {
        var configuration = PHPickerConfiguration()
        configuration.selectionLimit = viewModel.remainingImageCount()
        configuration.filter = .images
        
        let picker = PHPickerViewController(configuration: configuration)
        picker.delegate = self
        present(picker, animated: true)
    }
    
    private func showPermissionDeniedAlert() {
        let alert = UIAlertController(
            title: "사진 접근 권한 필요",
            message: "OOTD 사진을 업로드하려면 사진 라이브러리 접근 권한이 필요합니다.\n설정에서 권한을 허용해주세요.",
            preferredStyle: .alert
        )
        
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        
        alert.addAction(UIAlertAction(title: "설정으로 이동", style: .default) { _ in
            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                UIApplication.shared.open(settingsURL)
            }
        })
        
        present(alert, animated: true)
    }
    
    private func showMaxImagesAlert() {
        let alert = UIAlertController(
            title: "최대 개수 초과",
            message: "최대 5장까지만 선택할 수 있습니다.",
            preferredStyle: .alert
        )
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
}

extension OOTDWriteViewController: UITextViewDelegate {
    func textViewDidChange(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        placeholderLabel.isHidden = !textView.text.isEmpty
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            textView.resignFirstResponder()
            return false  // 줄바꿈 방지
        }
        return true
    }
}

extension OOTDWriteViewController: PHPickerViewControllerDelegate {
    func picker(_ picker: PHPickerViewController, didFinishPicking results: [PHPickerResult]) {
        picker.dismiss(animated: true)
        
        guard !results.isEmpty else { return }
        
        for result in results {
            result.itemProvider.loadObject(ofClass: UIImage.self) { [weak self] object, error in
                if let image = object as? UIImage {
                    DispatchQueue.main.async {
                        self?.viewModel.addImage(image)
                    }
                }
            }
        }
    }
}


extension OOTDWriteViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.getSelectedImagesValue().count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as! PhotoCell
        let image = viewModel.getSelectedImagesValue()[indexPath.item]
        cell.configure(with: image)
        
        cell.onDeleteTapped = { [weak self] in
            self?.viewModel.removeImage(at: indexPath.item)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let alert = UIAlertController(title: "사진 삭제", message: "이 사진을 삭제하시겠습니까?", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "취소", style: .cancel))
        alert.addAction(UIAlertAction(title: "삭제", style: .destructive) { [weak self] _ in
            self?.viewModel.removeImage(at: indexPath.item)
        })
        present(alert, animated: true)
    }
}
