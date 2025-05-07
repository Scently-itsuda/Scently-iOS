//
//  FilterViewController.swift
//  Scently
//
//  Created by 임재현 on 5/5/25.
//

import UIKit
import SnapKit

final class FilterViewController: UIViewController {
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "필터"
        label.font = .pretendard(.bold, size: 20)
        label.textColor = .black
        return label
    }()
    
    private let closeButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-close"), for: .normal)
        button.backgroundColor = .white
        return button
    }()
    
    private let dividerView = DividerView()
    private let dividerView2 = DividerView()
    private let verticalDividerView = DividerView(axis:.vertical)
    
    
    private let buttonStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.distribution = .fillEqually
        stackView.backgroundColor = .clear
        return stackView
    }()
    
    let section = ["가격","성별","어코드","부향률","브랜드","국가"]
    private var selectedButton: UIButton?
    
    private let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("초기화", for: .normal)
        button.titleLabel?.font = .pretendard(.regular, size: 14)
        button.setTitleColor(.gray3, for: .normal)
        button.backgroundColor = .white
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.gray3.cgColor
        button.layer.cornerRadius = 4.0
        return button
        
    }()
    
    private let applyButton: UIButton = {
        let button = UIButton()
        button.setTitle("적용하기", for: .normal)
        button.titleLabel?.font = .pretendard(.regular, size: 14)
        button.setTitleColor(.white, for: .normal)
        button.backgroundColor = .black
        button.layer.cornerRadius = 4.0
        return button
    }()
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private var sectionViews: [UIView] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupLayout()
        setupAddTarget()
        setupButtons()
        setupSectionViews()
        // 처음 버튼 선택 지정
        if let firstButton = buttonStackView.arrangedSubviews.first as? UIButton {
            didTapSection(firstButton)
        }
    }
    
    private func setupLayout() {
        self.view.addSubview(titleLabel)
        self.view.addSubview(closeButton)
        self.view.addSubview(dividerView)
        self.view.addSubview(verticalDividerView)
        self.view.addSubview(buttonStackView)
        self.view.addSubview(dividerView2)
        self.view.addSubview(resetButton)
        self.view.addSubview(applyButton)
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        
        titleLabel.snp.makeConstraints {
            $0.top.equalToSuperview().offset(24)
            $0.centerX.equalToSuperview()
        }
        
        closeButton.snp.makeConstraints {
            $0.size.equalTo(16)
            $0.centerY.equalTo(titleLabel)
            $0.trailing.equalToSuperview().inset(20)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(titleLabel.snp.bottom).offset(24)
            $0.leading.trailing.equalToSuperview()
        }
        
        verticalDividerView.snp.makeConstraints {
            $0.top.equalTo(dividerView)
            $0.leading.equalToSuperview().offset(105)
            $0.bottom.equalTo(dividerView2.snp.top)
        }
        
        buttonStackView.snp.makeConstraints {
            $0.top.equalTo(dividerView)
            $0.leading.equalToSuperview()
            $0.trailing.equalTo(verticalDividerView.snp.trailing)
            
        }
        
        dividerView2.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview()
            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-50)
        }
        
        resetButton.snp.makeConstraints {
            $0.top.equalTo(dividerView2.snp.bottom).offset(13)
            $0.leading.equalToSuperview().offset(32)
            $0.width.equalTo(112)
            $0.height.equalTo(44)
        }
        
        applyButton.snp.makeConstraints {
            $0.top.equalTo(resetButton.snp.top)
            $0.leading.equalTo(resetButton.snp.trailing).offset(16)
            $0.trailing.equalToSuperview().offset(-32)
            $0.height.equalTo(44)
        }
        scrollView.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom)
            $0.leading.equalTo(verticalDividerView.snp.trailing)
            $0.trailing.equalToSuperview()
            $0.bottom.equalTo(dividerView2.snp.top)
        }
        contentView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
    }
    
    private func setupButtons() {
        for (index,title) in section.enumerated() {
            let button = UIButton()
            button.setTitle(title, for: .normal)
            button.titleLabel?.font = .pretendard(.regular, size: 16)
            button.setTitleColor(.gray3, for: .normal)
            button.tag = index
            button.addTarget(self, action: #selector(didTapSection(_:)), for: .touchUpInside)
            button.snp.makeConstraints {
                $0.height.equalTo(52)
            }
            buttonStackView.addArrangedSubview(button)
        }
    }
    
    private func setupAddTarget() {
        closeButton.addTarget(self, action: #selector(closeButtonDidTap), for: .touchUpInside)
    }
    
    private func createSectionView(title:String,index:Int) -> UIView {
        switch title {
            case "가격":
                let priceView = UIView()
                priceView.backgroundColor = .yellow
                return priceView
            case "성별":
                let genderView = UIView()
                genderView.backgroundColor = .blue
                return genderView
            case "어코드":
                let accordView = UIView()
                accordView.backgroundColor = .systemPink
                return accordView
            case "부향률":
                let boohangView = UIView()
                boohangView.backgroundColor = .brown
                return boohangView
            case "브랜드":
                let brandView = UIView()
                brandView.backgroundColor = .blue
                return brandView
            case "국가":
                let nationView = UIView()
                nationView.backgroundColor = .gray
                return nationView
            
              
            
            
            default:
                let view =  UIView()
                view.backgroundColor = .red
                return view
            
        }
    }
    
    private func setupSectionViews() {
        // 각 섹션별 뷰 생성 및 contentView에 추가
        var previousView: UIView?
        
        for (index, sectionTitle) in section.enumerated() {
            let sectionView = createSectionView(title: sectionTitle, index: index)
            contentView.addSubview(sectionView)
            sectionViews.append(sectionView)
            
            sectionView.snp.makeConstraints {
                if let previousView = previousView {
                    $0.top.equalTo(previousView.snp.bottom)
                } else {
                    $0.top.equalTo(contentView)
                }
                $0.leading.trailing.equalTo(contentView)
                $0.height.equalTo(scrollView.snp.height)
            }
            
            previousView = sectionView
        }
        
        // 마지막 뷰의 bottom을 contentView의 bottom과 연결
        if let lastView = previousView {
            lastView.snp.makeConstraints {
                $0.bottom.equalTo(contentView)
            }
        }
    }
    
    @objc func closeButtonDidTap() {
        print("closeButtod Tapped")
        self.dismiss(animated: true)
    }
    
    @objc func didTapSection(_ sender: UIButton) {
        selectedButton?.backgroundColor = .clear
        selectedButton?.setTitleColor(.gray3,for: .normal)
        sender.backgroundColor = .black
        sender.setTitleColor(.white, for: .normal)
        selectedButton = sender
        
        let index = sender.tag
        
        if index < sectionViews.count {
            let sectionView = sectionViews[index]
            
            UIView.animate(withDuration: 0.3) {
                self.scrollView.contentOffset = CGPoint(x: 0, y: sectionView.frame.origin.y)
            }
        }
    }
}
