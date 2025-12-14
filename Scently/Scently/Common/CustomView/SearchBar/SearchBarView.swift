//
//  SearchBarView.swift
//  Scently
//
//  Created by dejay on 6/20/25.
//

import UIKit
import SnapKit

final class SearchBarView: UIView {
    private var containerView = UIView()
    private var searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        searchBar.tintColor = .DDDDDD
        searchBar.placeholder = "search"
        searchBar.searchBarStyle = .minimal
        return searchBar
    }()
    
    private var bottomView = UIView()
    private var countLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.light, size: 12)
        label.textColor = .gray3
        label.text = "000"
        return label
    }()
    private var countTitleLabel: UILabel = {
        let label = UILabel()
        label.font = .pretendard(.light, size: 12)
        label.textColor = .gray3
        label.text = "개"
        return label
    }()
    
    private var alignButton: UIButton = {
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
    
    // 설정 옵션
    struct Configuration {
        var placeholder: String = "search"
        var showBottomView: Bool = true
        
        static let `default` = Configuration()
    }
    
    private var configuration: Configuration
    
    init(configuration: Configuration = .default) {
        self.configuration = configuration
        super.init(frame: .zero)
        setupUI()
        setupConstraint()
        applyConfiguration()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func applyConfiguration() {
        searchBar.placeholder = configuration.placeholder
        bottomView.isHidden = !configuration.showBottomView
    }
    
    // 외부에서 개수 업데이트
    func updateCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
}

private extension SearchBarView {
    func setupUI() {
        self.addSubview(containerView)
        containerView.addSubview(searchBar)
        containerView.addSubview(bottomView)
        
        bottomView.addSubview(countLabel)
        bottomView.addSubview(countTitleLabel)
        bottomView.addSubview(alignButton)
    }
    
    func setupConstraint() {
        containerView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        searchBar.snp.makeConstraints {
            $0.top.equalTo(containerView.snp.top).inset(8)
            $0.leading.trailing.equalTo(containerView).inset(16)
            $0.height.equalTo(36)
        }
        
        bottomView.snp.makeConstraints {
            $0.top.equalTo(searchBar.snp.bottom)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        countLabel.snp.makeConstraints {
            $0.top.equalTo(bottomView.snp.top).inset(4)
            $0.leading.equalTo(bottomView.snp.leading).inset(24)
        }
        
        countTitleLabel.snp.makeConstraints {
            $0.centerY.equalTo(countLabel.snp.centerY)
            $0.leading.equalTo(countLabel.snp.trailing).offset(2)
        }
        
        alignButton.snp.makeConstraints {
            $0.top.equalTo(bottomView.snp.top)
            $0.trailing.equalTo(bottomView.snp.trailing).inset(20)
            $0.bottom.equalTo(bottomView.snp.bottom)
            $0.height.equalTo(20)
        }
    }
}
