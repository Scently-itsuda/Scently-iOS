//
//  HashtagBottomSheetViewController.swift
//  Scently
//
//  Created by 임재현 on 11/16/25.
//

import UIKit
import SnapKit

final class HashtagBottomSheetViewController: UIViewController {
    
    var onHashtagSelected: (([String]) -> Void)?
    
    private var selectedHashtags: [String] = []
    
    private let recommendedHashtags = [
        "OOTD", "데일리룩", "패션", "스타일", "오늘의옷",
        "데일리", "패션스타그램", "오오티디", "룩북", "코디"
    ]
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "태그 추가"
        label.font = .systemFont(ofSize: 20, weight: .bold)
        label.textColor = .black
        return label
    }()
    
    private lazy var closeButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(systemName: "xmark"), for: .normal)
        button.tintColor = .black
        button.addTarget(self, action: #selector(closeButtonTapped), for: .touchUpInside)
        return button
    }()
    
    private let searchTextField: UITextField = {
        let tf = UITextField()
        tf.placeholder = "태그 검색"
        tf.borderStyle = .roundedRect
        tf.backgroundColor = .systemGray6
        tf.font = .systemFont(ofSize: 16)
        tf.autocapitalizationType = .none
        tf.autocorrectionType = .no
        return tf
    }()
    
    private let recommendedLabel: UILabel = {
        let label = UILabel()
        label.text = "추천 태그"
        label.font = .systemFont(ofSize: 16, weight: .semibold)
        label.textColor = .black
        return label
    }()
    
    private lazy var hashtagCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.minimumInteritemSpacing = 8
        layout.minimumLineSpacing = 8
        layout.estimatedItemSize = UICollectionViewFlowLayout.automaticSize
        
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.showsVerticalScrollIndicator = false
        return cv
    }()
    
    private lazy var addButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("추가", for: .normal)
        button.titleLabel?.font = .systemFont(ofSize: 16, weight: .semibold)
        button.backgroundColor = .systemBlue
        button.setTitleColor(.white, for: .normal)
        button.layer.cornerRadius = 12
        button.addTarget(self, action: #selector(addButtonTapped), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupCollectionView()
        setupTextField()
    }

    private func setupUI() {
        view.addSubviews(
            titleLabel,
            closeButton,
            searchTextField,
            recommendedLabel,
            hashtagCollectionView,
            addButton
        )
    }
    
    private func setupConstraints() {
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        closeButton.snp.makeConstraints {
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.height.equalTo(44)
        }
        
        searchTextField.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(20)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(44)
        }
        
        recommendedLabel.snp.makeConstraints {
            $0.top.equalTo(searchTextField.snp.bottom).offset(24)
            $0.leading.equalToSuperview().offset(20)
        }
        
        hashtagCollectionView.snp.makeConstraints {
            $0.top.equalTo(recommendedLabel.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(addButton.snp.top).offset(-20)
        }
        
        addButton.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-16)
            $0.height.equalTo(52)
        }
    }
    
    private func setupCollectionView() {
        hashtagCollectionView.dataSource = self
        hashtagCollectionView.delegate = self
        hashtagCollectionView.register(HashtagCell.self, forCellWithReuseIdentifier: "HashtagCell")
    }
    
    private func setupTextField() {
        searchTextField.delegate = self
        searchTextField.addTarget(self, action: #selector(searchTextChanged), for: .editingChanged)
    }
    
    @objc private func closeButtonTapped() {
        dismiss(animated: true)
    }
    
    @objc private func addButtonTapped() {
        onHashtagSelected?(selectedHashtags)
        dismiss(animated: true)
    }
    
    @objc private func searchTextChanged() {
        // 검색 기능 구현 (추후)
    }
}

extension HashtagBottomSheetViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return recommendedHashtags.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "HashtagCell", for: indexPath) as! HashtagCell
        let hashtag = recommendedHashtags[indexPath.item]
        let isSelected = selectedHashtags.contains(hashtag)
        cell.configure(with: hashtag, isSelected: isSelected)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let hashtag = recommendedHashtags[indexPath.item]
        
        if let index = selectedHashtags.firstIndex(of: hashtag) {
            selectedHashtags.remove(at: index)
        } else {
            selectedHashtags.append(hashtag)
        }
        
        collectionView.reloadItems(at: [indexPath])
        updateAddButton()
    }
    
    private func updateAddButton() {
        if selectedHashtags.isEmpty {
            addButton.setTitle("추가", for: .normal)
        } else {
            addButton.setTitle("추가 (\(selectedHashtags.count))", for: .normal)
        }
    }
}


extension HashtagBottomSheetViewController: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}
