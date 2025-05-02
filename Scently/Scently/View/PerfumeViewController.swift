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
    }
    
    @objc
    func alertButtonDidTap() {
        print("alertButtonDidTap")
    }
}
