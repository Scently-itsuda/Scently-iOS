//
//  SearchBarView.swift
//  Scently
//
//  Created by dejay on 6/20/25.
//

import UIKit
import SnapKit

protocol SearchBarViewDelegate: AnyObject {
    func searchBarView(_ searchBarView: SearchBarView, didChangeSearchText text: String)
}

final class SearchBarView: UIView {
    
    weak var delegate: SearchBarViewDelegate?
    
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
        searchBar.delegate = self // 추가
        bottomView.isHidden = !configuration.showBottomView
    }
    
    // 외부에서 개수 업데이트
    func updateCount(_ count: Int) {
        countLabel.text = "\(count)"
    }
    
    func clearSearchText() {
        searchBar.text = ""
        searchBar.resignFirstResponder()
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

extension SearchBarView: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        delegate?.searchBarView(self, didChangeSearchText: searchText)
    }
}


final class PerfumeCell: UICollectionViewCell,ReuseIdentifying {
    private let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .systemGray6
        iv.layer.cornerRadius = 8
        return iv
    }()
    
    private let brandLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 12, weight: .medium)
        label.textColor = .systemGray
        return label
    }()
    
    private let nameLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 14, weight: .regular)
        label.textColor = .black
        label.numberOfLines = 2
        return label
    }()
    
    private let textStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .vertical
        stackView.spacing = 4
        stackView.alignment = .leading
        return stackView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        textStackView.addArrangedSubview(brandLabel)
        textStackView.addArrangedSubview(nameLabel)
        
        contentView.addSubviews(imageView, textStackView)
        contentView.backgroundColor = .white
        contentView.layer.cornerRadius = 8
        contentView.layer.borderWidth = 1
        contentView.layer.borderColor = UIColor.systemGray5.cgColor
    }
    
    private func setupConstraints() {
        imageView.snp.makeConstraints {
            $0.leading.equalToSuperview().offset(12)
            $0.centerY.equalToSuperview()
            $0.width.height.equalTo(60) // 정사각형 이미지
        }
        
        textStackView.snp.makeConstraints {
            $0.leading.equalTo(imageView.snp.trailing).offset(12)
            $0.trailing.equalToSuperview().offset(-12)
            $0.centerY.equalToSuperview()
        }
    }
    
    func configure(with perfume: Perfume) {
        brandLabel.text = perfume.brand
        nameLabel.text = perfume.name
        // 이미지 로딩 (Kingfisher 등 사용 권장)
        // imageView.kf.setImage(with: URL(string: perfume.imageURL))
    }
}
