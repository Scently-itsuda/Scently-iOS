//
//  WriteOOTDViewController.swift
//  Scently
//
//  Created by sy0201 on 9/14/25.
//

import UIKit
import SnapKit

final class WriteOOTDViewController: UIViewController {
    
    // MARK: - UI Components
    
    // Navigation Bar
    private let backButton = UIButton(type: .custom)
    private let titleLabel = UILabel()
    private let nextButton = UIButton(type: .custom)
    private let navigationSeparatorLine = UIView()
    
    // Image Upload Collection View
    private lazy var imageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 20)
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    // Content Text View
    private let contentTextView = UITextView()
    private let placeholderLabel = UILabel()
    
    // Bottom Section
    private let bottomSeparatorLine = UIView()
    private let imageAddButton = UIButton(type: .custom)
    private let tagButton = UIButton(type: .custom)
    
    // MARK: - Properties
    private var uploadedImages: [UIImage] = []
    private let maxImageCount = 4
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        setupActions()
        registerCell()
    }
}

// MARK: - Setup Methods
private extension WriteOOTDViewController {
    
    func setupUI() {
        view.backgroundColor = .white
        
        // Navigation Bar Setup
        backButton.setImage(UIImage(systemName: "chevron.left"), for: .normal)
        backButton.tintColor = .black
        
        titleLabel.text = "OOTD"
        titleLabel.font = UIFont.systemFont(ofSize: 18, weight: .semibold)
        titleLabel.textColor = .black
        titleLabel.textAlignment = .center
        
        nextButton.setTitle("다음", for: .normal)
        nextButton.setTitleColor(.systemBlue, for: .normal)
        nextButton.titleLabel?.font = UIFont.systemFont(ofSize: 16, weight: .medium)
        
        navigationSeparatorLine.backgroundColor = UIColor.systemGray5
        
        // Content Text View Setup
        contentTextView.backgroundColor = .clear
        contentTextView.font = UIFont.systemFont(ofSize: 16)
        contentTextView.textColor = .black
        contentTextView.delegate = self
        contentTextView.textContainerInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        placeholderLabel.text = "내용을 입력하세요."
        placeholderLabel.font = UIFont.systemFont(ofSize: 16)
        placeholderLabel.textColor = .systemGray3
        
        // Bottom Section Setup
        bottomSeparatorLine.backgroundColor = UIColor.systemGray5
        
        imageAddButton.setImage(UIImage(systemName: "photo"), for: .normal)
        imageAddButton.tintColor = .systemGray
        
        tagButton.setTitle("#태그입력", for: .normal)
        tagButton.setTitleColor(.systemGray, for: .normal)
        tagButton.titleLabel?.font = UIFont.systemFont(ofSize: 14)
        tagButton.contentHorizontalAlignment = .left
        
        // Add subviews
        view.addSubview(backButton)
        view.addSubview(titleLabel)
        view.addSubview(nextButton)
        view.addSubview(navigationSeparatorLine)
        view.addSubview(imageCollectionView)
        view.addSubview(contentTextView)
        view.addSubview(placeholderLabel)
        view.addSubview(bottomSeparatorLine)
        view.addSubview(imageAddButton)
        view.addSubview(tagButton)
    }
    
    func setupConstraints() {
        // Navigation Bar Constraints
        backButton.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide.snp.top).offset(10)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(24)
        }
        
        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.centerX.equalToSuperview()
        }
        
        nextButton.snp.makeConstraints {
            $0.centerY.equalTo(backButton.snp.centerY)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
        
        navigationSeparatorLine.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(15)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(0.5)
        }
        
        // Image Collection View Constraints
        imageCollectionView.snp.makeConstraints {
            $0.top.equalTo(navigationSeparatorLine.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(120)
        }
        
        // Content Text View Constraints
        contentTextView.snp.makeConstraints {
            $0.top.equalTo(imageCollectionView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(bottomSeparatorLine.snp.top)
        }
        
        placeholderLabel.snp.makeConstraints {
            $0.top.equalTo(contentTextView.snp.top).offset(25)
            $0.leading.equalTo(contentTextView.snp.leading).offset(25)
        }
        
        // Bottom Section Constraints
        bottomSeparatorLine.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(imageAddButton.snp.top).offset(-15)
            $0.height.equalTo(0.5)
        }
        
        imageAddButton.snp.makeConstraints {
            $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).inset(15)
            $0.leading.equalToSuperview().offset(20)
            $0.width.height.equalTo(24)
        }
        
        tagButton.snp.makeConstraints {
            $0.centerY.equalTo(imageAddButton.snp.centerY)
            $0.leading.equalTo(imageAddButton.snp.trailing).offset(15)
            $0.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(24)
        }
    }
    
    func setupActions() {
        backButton.addTarget(self, action: #selector(backButtonTapped), for: .touchUpInside)
        nextButton.addTarget(self, action: #selector(nextButtonTapped), for: .touchUpInside)
        imageAddButton.addTarget(self, action: #selector(imageAddButtonTapped), for: .touchUpInside)
        tagButton.addTarget(self, action: #selector(tagButtonTapped), for: .touchUpInside)
    }
    
    func registerCell() {
        imageCollectionView.register(ImageUploadCell.self, forCellWithReuseIdentifier: "ImageUploadCell")
    }
}

// MARK: - Action Methods
private extension WriteOOTDViewController {
    
    @objc func backButtonTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    @objc func nextButtonTapped() {
        // 다음 단계 처리 로직
        print("다음 버튼 탭됨")
    }
    
    @objc func imageAddButtonTapped() {
        // 이미지 선택 로직
        presentImagePicker()
    }
    
    @objc func tagButtonTapped() {
        // 태그 입력 로직
        print("태그 버튼 탭됨")
    }
    
    func presentImagePicker() {
        guard uploadedImages.count < maxImageCount else {
            showAlert(message: "최대 \(maxImageCount)장까지 업로드할 수 있습니다.")
            return
        }
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
    }
    
    func showAlert(message: String) {
        let alert = UIAlertController(title: "알림", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "확인", style: .default))
        present(alert, animated: true)
    }
    
    func updatePlaceholderVisibility() {
        placeholderLabel.isHidden = !contentTextView.text.isEmpty
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate
extension WriteOOTDViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return maxImageCount
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ImageUploadCell", for: indexPath) as! ImageUploadCell
        
        if indexPath.item < uploadedImages.count {
            cell.configure(with: uploadedImages[indexPath.item])
        } else {
            cell.configure(with: nil)
        }
        
        cell.delegate = self
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if indexPath.item >= uploadedImages.count {
            presentImagePicker()
        }
    }
}

// MARK: - UITextViewDelegate
extension WriteOOTDViewController: UITextViewDelegate {
    
    func textViewDidChange(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        updatePlaceholderVisibility()
    }
}

// MARK: - UIImagePickerControllerDelegate
extension WriteOOTDViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedImage = info[.editedImage] as? UIImage ?? info[.originalImage] as? UIImage else {
            picker.dismiss(animated: true)
            return
        }
        
        uploadedImages.append(selectedImage)
        imageCollectionView.reloadData()
        picker.dismiss(animated: true)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true)
    }
}

// MARK: - ImageUploadCellDelegate
extension WriteOOTDViewController: ImageUploadCellDelegate {
    func didTapDeleteButton(at cell: ImageUploadCell) {
        guard let indexPath = imageCollectionView.indexPath(for: cell),
              indexPath.item < uploadedImages.count else { return }
        
        uploadedImages.remove(at: indexPath.item)
        imageCollectionView.reloadData()
    }
}

// MARK: - ImageUploadCell
protocol ImageUploadCellDelegate: AnyObject {
    func didTapDeleteButton(at cell: ImageUploadCell)
}

class ImageUploadCell: UICollectionViewCell {
    
    weak var delegate: ImageUploadCellDelegate?
    
    private let imageView = UIImageView()
    private let deleteButton = UIButton(type: .custom)
    private let addLabel = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        backgroundColor = UIColor.systemGray6
        layer.cornerRadius = 8
        clipsToBounds = true
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        
        deleteButton.setImage(UIImage(systemName: "xmark.circle.fill"), for: .normal)
        deleteButton.tintColor = .systemGray
        deleteButton.backgroundColor = .white
        deleteButton.layer.cornerRadius = 10
        deleteButton.addTarget(self, action: #selector(deleteButtonTapped), for: .touchUpInside)
        
        addLabel.text = "+"
        addLabel.textAlignment = .center
        addLabel.font = UIFont.systemFont(ofSize: 24, weight: .light)
        addLabel.textColor = .systemGray3
        
        contentView.addSubview(imageView)
        contentView.addSubview(deleteButton)
        contentView.addSubview(addLabel)
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        deleteButton.snp.makeConstraints {
            $0.top.trailing.equalToSuperview().inset(4)
            $0.width.height.equalTo(20)
        }
        
        addLabel.snp.makeConstraints {
            $0.center.equalToSuperview()
        }
    }
    
    @objc private func deleteButtonTapped() {
        delegate?.didTapDeleteButton(at: self)
    }
    
    func configure(with image: UIImage?) {
        if let image = image {
            imageView.image = image
            deleteButton.isHidden = false
            addLabel.isHidden = true
        } else {
            imageView.image = nil
            deleteButton.isHidden = true
            addLabel.isHidden = false
        }
    }
}
