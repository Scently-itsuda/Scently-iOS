//
//  PerfumeViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit
import SnapKit

final class PerfumeViewController: UIViewController {
    
    private let logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "LOGO")
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    private let searchButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-search2"), for: .normal)
        return button
    }()
    
    private let alertButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-bell2"), for: .normal)
        return button
    }()
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .white
        stackView.spacing = 8
        stackView.alignment = .center
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    private let logoStackView: UIStackView = {
       let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.backgroundColor = .blue
        stackView.distribution = .fill
        stackView.alignment = .center
        return stackView
    }()
    
    private let spacerView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        return view
    }()
    
    private let divider1 = DividerView()
    
    let tag = TagListView(title: "가격", buttonType: .delete)
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let containerView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 8
        stackView.alignment = .fill
        stackView.distribution = .equalSpacing
        
        return stackView
    }()
    
    private let divider2 = DividerView()
    
    private let countLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.light, size: 12)
        label.text = "000개"
        label.textColor = .black
        return label
    }()
    
    private let sortButton: UIButton = {
        let button = UIButton()
        button.setTitle("인기순", for: .normal)
        button.setImage(UIImage(named: "icon-updown"), for: .normal)
        button.titleLabel?.font = .pretendard(.bold, size: 12)
        button.setTitleColor(.gray3, for: .normal)
        button.tintColor = .gray3
        button.semanticContentAttribute = .forceRightToLeft
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 8, bottom: 0, right: 0)
        return button
    }()
    
    private lazy var perfuneCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        
        let inset: CGFloat = 16
        let spacing: CGFloat = 12
        let availableWidth = UIScreen.main.bounds.width - (inset * 2)
        let estimatedItemWidth: CGFloat = 100  // 최소 보장할 셀 너비
        let itemsInRow = floor((availableWidth + spacing) / (estimatedItemWidth + spacing))
        let totalSpacing = spacing * (itemsInRow - 1)
        let itemWidth = (availableWidth - totalSpacing) / itemsInRow

        layout.itemSize = CGSize(width: itemWidth, height: itemWidth * 1.4)
        layout.sectionInset = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
        layout.minimumLineSpacing = spacing
        layout.minimumInteritemSpacing = spacing
        
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .white
        collectionView.showsVerticalScrollIndicator = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(PerfumeCollectionViewCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        print("PerfumeViewController init")
        setupUI()
        setAddtarget()
    }
    
    private func setupUI() {


        self.view.addSubview(logoStackView)
       
        self.buttonStackView.addArrangedSubview(searchButton)
        self.buttonStackView.addArrangedSubview(alertButton)
        logoStackView.backgroundColor = .clear
        self.logoStackView.addArrangedSubview(logoImageView)
        self.logoStackView.addArrangedSubview(spacerView)
        self.logoStackView.addArrangedSubview(buttonStackView)
        
        self.view.addSubview(divider1)
        self.view.addSubview(divider2)
//        self.scrollView.addSubview(tag)
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        self.view.addSubview(countLabel)
        self.view.addSubview(sortButton)
        self.view.addSubview(perfuneCollectionView)
       

        logoStackView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(20)
            $0.leading.equalTo(self.view.safeAreaInsets).offset(20)
            $0.trailing.equalTo(self.view.safeAreaLayoutGuide).offset(-20)
            $0.height.equalTo(24)
        }
        
        logoImageView.snp.makeConstraints {
            $0.width.equalTo(108)
            $0.height.equalTo(20)
        }
        buttonStackView.snp.makeConstraints {
            $0.width.equalTo(56)
            $0.height.equalTo(24)
        }
        
        searchButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        alertButton.snp.makeConstraints {
            $0.width.height.equalTo(24)
        }
        
        divider1.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(logoStackView.snp.bottom).offset(24)
        }
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(divider1.snp.bottom)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(46)
            
        }
//        scrollView.backgroundColor = .green

        
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
            $0.height.equalToSuperview()
        }
//        containerView.backgroundColor = .yellow
        containerView.isLayoutMarginsRelativeArrangement = true
        containerView.layoutMargins = UIEdgeInsets(top: 9, left: 20, bottom: 9, right: 20)
        
        let titles = ["전체","가격","성별","부향률","브랜드","국가","123","1234","123456"]
        
        for title in titles {
            let tag = TagListView(title: title, buttonType: .dropDown)
            tag.snp.makeConstraints {
//                $0.leading.equalToSuperview().offset(20)
                $0.height.equalTo(28).priority(.low)
            }
            
            tag.onTap = {
                print("View tapped\(title)")
            }

            tag.onAction = {
                print("Button tapped\(title)")
            }
            containerView.addArrangedSubview(tag)
//            tag.backgroundColor = .blue.withAlphaComponent(0.3)
            tag.isUserInteractionEnabled = true

        }
        
        divider2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.top.equalTo(scrollView.snp.bottom)
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(divider2.snp.bottom).offset(5)
            $0.leading.equalToSuperview().offset(20)
        }
        
        sortButton.snp.makeConstraints {
            $0.top.equalTo(divider2.snp.bottom).offset(5)
            $0.trailing.equalToSuperview().offset(-20)
            $0.width.equalTo(47)
            $0.height.equalTo(14)
        }
        
        perfuneCollectionView.snp.makeConstraints {
            $0.top.equalTo(countLabel.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalToSuperview()
            
        }

    }
    
    private func setAddtarget() {
        searchButton.addTarget(self, action: #selector(searchButtonDidTap), for: .touchUpInside)
        alertButton.addTarget(self, action: #selector(alertButtonDidTap), for: .touchUpInside)
        
        tag.onAction = {print("onAction")}
        tag.onTap = {print("onTap")}
    }
    
    @objc
    func searchButtonDidTap() {
        print("searchButtonDidTap")
        let logoViewBottomPosition = self.logoStackView.frame.origin.y + self.logoStackView.frame.size.height
        let viewHeight = self.view.frame.height
        let availabelHeight = viewHeight - logoViewBottomPosition
        print(availabelHeight)
        
        let filterVC = FilterViewController()
        
        if let sheet = filterVC.sheetPresentationController {
            sheet.detents = [.custom { [weak self] context in
                guard let self = self else { return 500 }
                
                print("logoStackView frame: \(self.logoStackView.frame)")
                print("logoStackView bounds: \(self.logoStackView.bounds)")
                print("View height: \(self.view.frame.height)")
                
                // 좌표계 변환을 사용하여 정확한 위치 계산
                let convertedFrame = self.view.convert(self.logoStackView.frame, from: self.logoStackView.superview)
                let logoViewBottomPosition = convertedFrame.maxY
                
                // SafeArea 고려
//                let safeAreaTopInset = self.view.safeAreaInsets.top
//                let safeAreaBottomInset = self.view.safeAreaInsets.bottom
                
                // 실제 사용 가능한 높이 계산 (SafeArea 고려)
                let availableHeight = self.view.frame.height - logoViewBottomPosition
                
                print("Calculated height: \(availableHeight)")
                
                // 원하는 높이보다 약간 작게 설정하여 .large와 구분되게 만들기
                return min(availableHeight - 40, 750)
            }]
            sheet.prefersGrabberVisible = true
            sheet.preferredCornerRadius = 30
        }
        present(filterVC,animated: true)
      
    }
    
    @objc
    func alertButtonDidTap() {
        print("alertButtonDidTap")
    }
}

extension PerfumeViewController: UICollectionViewDelegate {
    
}

extension PerfumeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? PerfumeCollectionViewCell else {return UICollectionViewCell()}
        cell.backgroundColor = .white
        return cell
    }
    
    
}


