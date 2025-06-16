//
//  PerfumeDetailViewController.swift
//  Scently
//
//  Created by 임재현 on 6/8/25.
//

import UIKit
import SnapKit
import Combine

final class PerfumeDetailViewController: UIViewController {
    
    let volume = ["30ML","50ML","100ML","150ML"]
    let selectedML = "50ML"
    let concentration = ["퍼퓸","오 드 퍼퓸","오 드 뚜왈렛","오 드 코롱","오 프레쉬"]
    let concentrationSubtitles = ["20% ~ 40%","15% ~ 20%","5% ~ 15%","2% ~ 5%","1% ~ 3%"]
    let selectedConcentration = "오 드 퍼퓸"
    private let accords = ["🍊 시트러스", "🌳 우디", "💚 그린"]
    
    private let notes = ["탑노트","미들노트","베이스 노트"]
    
    private var cancellables = Set<AnyCancellable>()
    @Published private var selectedAccordIndex: Int? = nil
    private var accordButtons: [OptionButton] = []
    private var currentTooltip: UIView?
    
    private let scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()
    
    private let containerView: UIView = {
        let view = UIView()
        view.backgroundColor = .clear
        return view
    }()
    
    private let perfumeImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "perfume")
        imageView.backgroundColor = .white
        return imageView
    }()
    
    private let perfumeBrandLabel: UILabel = {
        let label = UILabel()
        label.text = "DIOR"
        label.font = .pretendard(.light, size: 12)
        label.textColor = .gray3
        return label
    }()
    
    private let perfumeTitleLabel: UILabel = {
        let label = UILabel()
        label.text = "미스 디올 오 드 퍼퓸"
        label.font = .pretendard(.bold, size: 16)
        label.textColor = .black
        return label
    }()
    
    private let heartButton: UIButton = {
        let button = UIButton()
        button.setImage(UIImage(named: "icon-heart-fill"), for: .normal)
        return button
    }()
    
    private let heartLabel: UILabel = {
        let label = UILabel()
        label.text = "123456"
        label.font = .pretendard(.regular, size: 10)
        label.textColor = .black
        return label
    }()
    
    private let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "119,000원"
        label.font = .pretendard(.bold, size: 20)
        label.textColor = .black
        return label
    }()
    
    private let volumeStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 12
        return stackView
    }()
    
    private let dividerView = DividerView(backgroundColor: .gray4,height: 4)
    
    private let concentrationIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon-perfume")
        return imageView
    }()
    
    private let concentrationLabel : UILabel = {
        let label = UILabel()
        label.text = "부향률"
        label.font = .pretendard(.bold, size: 13)
        label.textColor = .black
        return label
    }()
    
    private let concentrationStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.backgroundColor = .clear
        stackView.spacing = 0
        return stackView
    }()

    private let concentrationBackgroundView: UIView = {
        let view = UIView()
        view.backgroundColor = .gray4
        return view
    }()
    
    private let dividerView2 = DividerView(backgroundColor: .gray4,height: 1)
    
    private let accordIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon-perfume")
        return imageView
    }()
    
    private let accordLabel : UILabel = {
        let label = UILabel()
        label.text = "어코드"
        label.font = .pretendard(.bold, size: 13)
        label.textColor = .black
        return label
    }()
    
    private let dividerView3 = DividerView(backgroundColor: .gray4,height: 1)
    
    private lazy var accordCollectionView: UICollectionView = {
        let layout = createFixedRowLayout()
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.showsVerticalScrollIndicator = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isScrollEnabled = false
        collectionView.register(AccordButtonCell.self, forCellWithReuseIdentifier: "AccordButtonCell")
        collectionView.delegate = self
        collectionView.dataSource = self
        return collectionView
    }()
    
    private let noteIconImage: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.image = UIImage(named: "icon-perfume")
        return imageView
    }()
    
    private let noteLabel : UILabel = {
        let label = UILabel()
        label.text = "노트"
        label.font = .pretendard(.bold, size: 13)
        label.textColor = .black
        return label
    }()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        setupButtons()
        setupConcentrationButtons()
        setupAccordViews()
        setupLayout()
    }
    
    private func createFixedRowLayout() -> UICollectionViewCompositionalLayout {
        let sectionProvider = { (sectionIndex: Int, environment: NSCollectionLayoutEnvironment) -> NSCollectionLayoutSection? in
            
            var groups: [NSCollectionLayoutGroup] = []
            let totalItems = self.accords.count
            
            print("===== 3개씩 강제 그룹핑 =====")
            print("총 아이템 개수: \(totalItems)")
            
            for i in stride(from: 0, to: totalItems, by: 3) {
                var items: [NSCollectionLayoutItem] = []
                
                // 한 줄에 3개씩
                let itemsInThisRow = min(3, totalItems - i)
                
                print("줄 \(i/3 + 1): \(itemsInThisRow)개 아이템 (인덱스 \(i)~\(i + itemsInThisRow - 1))")
                
                for j in 0..<itemsInThisRow {
                    let itemSize = NSCollectionLayoutSize(
                        widthDimension: .estimated(80),
                        heightDimension: .absolute(36)
                    )
                    let item = NSCollectionLayoutItem(layoutSize: itemSize)
                    
                    if j == 0 {
                        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 4)
                    } else {
                        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 4, bottom: 0, trailing: 4)
                    }
                    
                    items.append(item)
                }
                
                let groupSize = NSCollectionLayoutSize(
                    widthDimension: .fractionalWidth(1.0),
                    heightDimension: .absolute(40)
                )
                let group = NSCollectionLayoutGroup.horizontal(
                    layoutSize: groupSize,
                    subitems: items
                )
                group.interItemSpacing = .fixed(15)
                groups.append(group)
            }
            
            print("총 \(groups.count)개 줄 생성")
            
            let containerGroupSize = NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .estimated(CGFloat(groups.count * 44))
            )
            let containerGroup = NSCollectionLayoutGroup.vertical(
                layoutSize: containerGroupSize,
                subitems: groups
            )
            containerGroup.interItemSpacing = .fixed(12)
            
            let section = NSCollectionLayoutSection(group: containerGroup)
            section.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 20)
            return section
        }
        
        return UICollectionViewCompositionalLayout(sectionProvider: sectionProvider)
    }
    
    private func setupUI() {
        self.view.addSubview(scrollView)
        scrollView.addSubview(containerView)
        self.containerView
            .addSubviews(
                perfumeImageView,
                perfumeBrandLabel,
                perfumeTitleLabel,
                heartButton,
                heartLabel,
                priceLabel,
                volumeStackView,
                dividerView,
                concentrationIconImage,
                concentrationLabel,
                concentrationBackgroundView,
                concentrationStackView,
                dividerView2,
                accordIconImage,
                accordLabel,
                accordCollectionView,
                dividerView3,
                noteIconImage,
                noteLabel
            )
        
    }
    
    private func setupLayout() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
        }
        
        scrollView.backgroundColor = .white
        containerView.backgroundColor = .white
        
        perfumeImageView.snp.makeConstraints {
            $0.top.equalToSuperview()
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(375)
        }
        
        perfumeBrandLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeImageView.snp.bottom).offset(10)
            $0.leading.equalToSuperview().offset(16)
        }
        
        perfumeTitleLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeBrandLabel.snp.bottom).offset(4)
            $0.leading.equalToSuperview().offset(16)
        }
        
        priceLabel.snp.makeConstraints {
            $0.top.equalTo(perfumeTitleLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
        }
        
        heartButton.snp.makeConstraints {
            $0.top.equalTo(perfumeImageView.snp.bottom).offset(20)
            $0.trailing.equalToSuperview().inset(20)
            $0.size.equalTo(24)
        }
        
        heartLabel.snp.makeConstraints {
            $0.top.equalTo(heartButton.snp.bottom).offset(4)
            $0.centerX.equalTo(heartButton.snp.centerX)
        }
        
        volumeStackView.snp.makeConstraints {
            $0.top.equalTo(priceLabel.snp.bottom).offset(20)
            $0.leading.equalToSuperview().offset(16)
            $0.height.equalTo(28)
        }
        
        dividerView.snp.makeConstraints {
            $0.top.equalTo(volumeStackView.snp.bottom).offset(8)
            $0.leading.trailing.equalToSuperview()
        }
        
        concentrationIconImage.snp.makeConstraints {
            $0.top.equalTo(dividerView.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(20)
        }
        
        concentrationLabel.snp.makeConstraints {
            $0.leading.equalTo(concentrationIconImage.snp.trailing).offset(4)
            $0.centerY.equalTo(concentrationIconImage.snp.centerY)
        }
        
        concentrationBackgroundView.snp.makeConstraints {
            $0.top.equalTo(concentrationIconImage.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.height.equalTo(40)
        }
        
        concentrationStackView.snp.makeConstraints {
            $0.top.equalTo(concentrationIconImage.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(60)
        }
        
        dividerView2.snp.makeConstraints {
            $0.top.equalTo(concentrationStackView.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        accordIconImage.snp.makeConstraints {
            $0.top.equalTo(dividerView2.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(20)
        }
        
        accordLabel.snp.makeConstraints {
            $0.leading.equalTo(accordIconImage.snp.trailing).offset(4)
            $0.centerY.equalTo(accordIconImage.snp.centerY)
        }
        
        dividerView3.snp.makeConstraints {
            $0.top.equalTo(accordCollectionView.snp.bottom).offset(28)
            $0.leading.trailing.equalToSuperview().inset(16)
        }
        
        noteIconImage.snp.makeConstraints {
            $0.top.equalTo(dividerView3.snp.bottom).offset(16)
            $0.leading.equalToSuperview().offset(16)
            $0.size.equalTo(20)
        }
        
        noteLabel.snp.makeConstraints {
            $0.leading.equalTo(noteIconImage.snp.trailing).offset(4)
            $0.centerY.equalTo(noteIconImage.snp.centerY)
            $0.bottom.equalToSuperview().inset(10)
        }
    }
    
    private func setupButtons() {
        for (index,title) in volume.enumerated() {
            let button = OptionButton(title: title)
            button.titleLabel?.font = .pretendard(.bold, size: 12)
            button.setTitleColor(.gray3, for: .normal)
            button.updateSelectedState(isSelected: title == selectedML)
            button.isEnabled = false
            button.tag = index

            button.snp.makeConstraints {
                $0.height.equalTo(28)
            }
            volumeStackView.addArrangedSubview(button)
        }
    }
    
    private func setupConcentrationButtons() {
        for (index, title) in concentration.enumerated() {
            let containerView = createConcentrationContainer(
                title: title,
                subtitle: concentrationSubtitles[index],
                isSelected: title == selectedConcentration
            )
            concentrationStackView.addArrangedSubview(containerView)
        }
    }
    
    private func createConcentrationContainer(title: String, subtitle: String, isSelected: Bool) -> UIView {
        let container = UIView()
        
        let button = OptionButton(title: title)
        button.snp.makeConstraints {
            $0.height.equalTo(40)
        }
        button.isEnabled = false
        let indicator = UIImageView(image: UIImage(named: "Ellipse 392"))
        indicator.contentMode = .scaleAspectFit
        let percentLabel = UILabel()
        percentLabel.text = subtitle
        percentLabel.font = .pretendard(.regular, size: 10)
        percentLabel.textColor = .black
        
        container.addSubviews(button, indicator, percentLabel)
        
        button.snp.makeConstraints {
            $0.top.leading.trailing.equalToSuperview()
        }
        indicator.snp.makeConstraints {
            $0.top.equalTo(button.snp.bottom).offset(-4)
            $0.centerX.equalTo(button.snp.centerX)
            $0.size.equalTo(8)
        }
        
        percentLabel.snp.makeConstraints {
            $0.top.equalTo(indicator.snp.bottom).offset(8)
            $0.centerX.equalTo(button.snp.centerX)
        }
        button.updateSelectedState(isSelected: isSelected)
        indicator.isHidden = !isSelected
        percentLabel.isHidden = !isSelected
        
        return container
    }
    
    private func setupAccordViews() {
        accordCollectionView.snp.makeConstraints {
            $0.leading.trailing.equalToSuperview().inset(20)
            $0.top.equalTo(accordIconImage.snp.bottom).offset(12)
            $0.height.equalTo(calculateCollectionViewHeight())
        }
        setupAccordBinding()
    }
    
    private func calculateCollectionViewHeight() -> CGFloat {
        let totalItems = accords.count
        let totalRows = Int(ceil(Double(totalItems) / 3.0))
        let cellHeight: CGFloat = 40
        let lineSpacing: CGFloat = 12
        
        let calculatedHeight = CGFloat(totalRows) * cellHeight + CGFloat(max(0, totalRows - 1)) * lineSpacing
        
        print(" CollectionView 높이 계산 (3개 고정):")
        print("   - 총 아이템: \(totalItems)")
        print("   - 총 줄 수: \(totalRows)")
        print("   - 계산된 높이: \(calculatedHeight)")
        
        return calculatedHeight
    }
    
    private func updateCollectionViewHeight() {
        accordCollectionView.layoutIfNeeded()
        let contentHeight = accordCollectionView.collectionViewLayout.collectionViewContentSize.height
        
        print("CollectionView contentHeight: \(contentHeight)")
        
        accordCollectionView.snp.remakeConstraints {
                $0.leading.trailing.equalToSuperview().inset(20)
                $0.top.equalTo(accordIconImage.snp.bottom).offset(16)
                $0.height.equalTo(contentHeight)
            }
        
        view.layoutIfNeeded()
    }
    
    private func setupAccordBinding() {
        $selectedAccordIndex
            .sink { [weak self] selectedIndex in
                self?.updateAccordButtonStates(selectedIndex: selectedIndex)
            }
            .store(in: &cancellables)
    }

    private func updateAccordButtonStates(selectedIndex: Int?) {
        accordCollectionView.reloadData()
        
        DispatchQueue.main.async {
                self.updateCollectionViewHeight()
            }
        if let selectedIndex = selectedIndex {
            print("선택된 어코드: \(accords[selectedIndex])")
        } else {
            print("어코드 선택 해제")
        }
    }
    private func setupNoteLabels() {
        for note in notes {
            let label = UILabel()
            label.text = ""
        }
    }
    

    private func createToolTip(text: String, direction: TooltipDirection) -> UIView {
        let toolTipContainer = UIView()
        toolTipContainer.backgroundColor = .clear
        
        let backgroundImageView = UIImageView()
        switch direction {
            
        case .right:  // 꼬리가 왼쪽에 있는 말풍선
            backgroundImageView.image = UIImage(named: "Group 70")
        case .left:   // 꼬리가 오른쪽에 있는 말풍선
            backgroundImageView.image = UIImage(named: "Group 71")
        case .center:
                backgroundImageView.image = UIImage(named: "Group 70")
            
        default:
            backgroundImageView.image = UIImage(named: "Group 70")
        }
        
        let textLabel = UILabel()
           textLabel.text = text
           textLabel.font = .pretendard(.regular, size: 12)
           textLabel.textColor = .white
           textLabel.numberOfLines = 0
           textLabel.textAlignment = .center
           
        toolTipContainer.addSubview(backgroundImageView)
        toolTipContainer.addSubview(textLabel)
           
           // 레이아웃
           backgroundImageView.snp.makeConstraints {
               $0.edges.equalToSuperview()
           }
           
           textLabel.snp.makeConstraints {
               $0.center.equalToSuperview()
               $0.leading.trailing.equalToSuperview().inset(16)
               $0.top.bottom.equalToSuperview().inset(12)
           }
           
           return toolTipContainer
    }
    
    private func hideTooltip() {
        UIView.animate(withDuration: 0.2) {
            self.currentTooltip?.alpha = 0
            self.currentTooltip?.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        } completion: { _ in
            self.currentTooltip?.removeFromSuperview()
            self.currentTooltip = nil
        }
    }

    private func getAccordDescription(for index: Int) -> String {
        let descriptions = [
            "🍊 시트러스": "상큼하고 활기찬 향으로 레몬, 오렌지 등이 포함됩니다",
            "🌳 우디": "따뜻하고 깊은 나무 향으로 자연스러운 느낌을 줍니다",
            "💚 그린": "꽃향기가 주를 이루는 로맨틱하고 우아한 향입니다"
        ]
        return descriptions[accords[index]] ?? "123"
    }
}

extension PerfumeDetailViewController: UICollectionViewDataSource,UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return accords.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "AccordButtonCell", for: indexPath) as! AccordButtonCell
        
        let isSelected = selectedAccordIndex == indexPath.item
        cell.configure(with: accords[indexPath.item], tag: indexPath.item, isSelected: isSelected)

        return cell
    }

    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let tappedIndex = indexPath.item
        
        print("\n🎯 ===== 셀 클릭 디버깅 =====")
        print("클릭된 셀 인덱스: \(tappedIndex)")
        print("전체 셀 개수: \(accords.count)")
        
        print("📱 CollectionView 정보:")
        print("   - CollectionView frame: \(collectionView.frame)")
        print("   - CollectionView bounds: \(collectionView.bounds)")
        print("   - ContentSize: \(collectionView.contentSize)")
        print("   - ContentOffset: \(collectionView.contentOffset)")
        
        // 셀 정보
        guard let cellAttributes = collectionView.layoutAttributesForItem(at: indexPath) else {
            print("셀 attributes를 가져올 수 없습니다")
            return
        }
        
        let cellFrame = cellAttributes.frame
        print("셀 정보:")
        print(" - CollectionView 내 셀 frame: \(cellFrame)")
        
        let buttonFrameInView = collectionView.convert(cellFrame, to: self.view)
        print("   - View 기준 셀 frame: \(buttonFrameInView)")
        
        // 다른 셀들과 비교
        for i in 0..<accords.count {
            let ip = IndexPath(item: i, section: 0)
            if let attr = collectionView.layoutAttributesForItem(at: ip) {
                let converted = collectionView.convert(attr.frame, to: self.view)
                print("   - 셀 \(i): CollectionView내(\(attr.frame)) → View기준(\(converted))")
            }
        }

        if selectedAccordIndex == tappedIndex {
            selectedAccordIndex = nil
            hideTooltip()
        } else {
            selectedAccordIndex = tappedIndex
            showToolTipAtPosition(frame: buttonFrameInView, text: getAccordDescription(for: indexPath.item))
        }
    }
}

extension PerfumeDetailViewController {

    private func showToolTipAtPosition(frame: CGRect, text: String) {
        currentTooltip?.removeFromSuperview()
        currentTooltip = nil
        
        let tooltipWidth: CGFloat = 130
        let tooltipHeight: CGFloat = 80
        let margin: CGFloat = 10
        
        print("🔍 ===== 고정 레이아웃에서 툴팁 테스트 =====")
        print("버튼 frame (view 기준): \(frame)")
        
        // 기존 ScrollView 방식으로 툴팁 추가
        let buttonFrameInScrollView = self.view.convert(frame, to: scrollView)
        let scrollViewWidth = scrollView.bounds.width
        
        let rightSpace = scrollViewWidth - buttonFrameInScrollView.maxX
        let leftSpace = buttonFrameInScrollView.minX
        
        var tooltipX: CGFloat
        if rightSpace >= tooltipWidth + margin {
            tooltipX = buttonFrameInScrollView.minX
        } else if leftSpace >= tooltipWidth + margin {
            tooltipX = buttonFrameInScrollView.maxX - tooltipWidth
        } else {
            tooltipX = buttonFrameInScrollView.midX - (tooltipWidth / 2)
        }
        
        tooltipX = max(margin, min(tooltipX, scrollViewWidth - tooltipWidth - margin))
        let tooltipY = buttonFrameInScrollView.maxY + 5
        
        let tooltip = createToolTip(text: text, direction: rightSpace >= tooltipWidth + margin ? .right : .left)
        scrollView.addSubview(tooltip)
        currentTooltip = tooltip
        
        tooltip.frame = CGRect(x: tooltipX, y: tooltipY, width: tooltipWidth, height: tooltipHeight)
        
        print("툴팁 추가 완료 - 셀 위치 변화 없어야 함")
        
        // 애니메이션
        tooltip.alpha = 0
        tooltip.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8) {
            tooltip.alpha = 1
            tooltip.transform = .identity
        }
    }
}
