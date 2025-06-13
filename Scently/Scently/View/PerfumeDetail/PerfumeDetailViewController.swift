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
    private let accords = ["🍊 시트러스", "🌳 우디", "💚 그린","🍊 시트러스", "🌳 우디", "💚 그린","🍊 시트러스", "🌳 우디", "💚 그린"]
    
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
    
    private let accordScrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.backgroundColor = .clear
        return scrollView
    }()

    private let accordStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fill
        stackView.spacing = 15
        return stackView
    }()
    
    private let dividerView3 = DividerView(backgroundColor: .gray4,height: 1)
    
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
                accordScrollView,
                dividerView3,
                noteIconImage,
                noteLabel
            )
        self.accordScrollView.addSubview(accordStackView)
        
    }
    
    private func setupLayout() {
        
        scrollView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide).offset(50)
            $0.leading.trailing.bottom.equalToSuperview()
        }
        
        containerView.snp.makeConstraints {
            $0.edges.equalTo(scrollView.contentLayoutGuide)
            $0.width.equalTo(scrollView.frameLayoutGuide)
//            $0.edges.equalToSuperview()
//            $0.height.equalToSuperview()
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
        
        accordScrollView.snp.makeConstraints {
            $0.top.equalTo(accordIconImage.snp.bottom).offset(12)
            $0.leading.trailing.equalToSuperview().inset(16)
            $0.height.equalTo(36)
        }
        
        accordStackView.snp.makeConstraints {
               $0.edges.equalTo(accordScrollView.contentLayoutGuide)
               $0.height.equalTo(accordScrollView.frameLayoutGuide)
           }
        
        dividerView3.snp.makeConstraints {
            $0.top.equalTo(accordStackView.snp.bottom).offset(28)
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
        for (index, accord) in accords.enumerated() {
            let button = OptionButton(title: accord)
            button.tag = index
            button.addTarget(self, action: #selector(accordButtonDidTapped(_:)), for: .touchUpInside)
            accordButtons.append(button)
            accordStackView.addArrangedSubview(button)
        }
        setupAccordBinding()
    }
    
    private func setupAccordBinding() {
        $selectedAccordIndex
            .sink { [weak self] selectedIndex in
                self?.updateAccordButtonStates(selectedIndex: selectedIndex)
            }
            .store(in: &cancellables)
    }

    private func updateAccordButtonStates(selectedIndex: Int?) {
        for (index, button) in accordButtons.enumerated() {
            let isSelected = index == selectedIndex
            button.updateSelectedState(isSelected: isSelected)
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
    
    @objc private func accordButtonDidTapped(_ sender: OptionButton) {
        let tappedIndex = sender.tag
        
        // 토글 로직
        if selectedAccordIndex == tappedIndex {
            selectedAccordIndex = nil
            hideTooltip()
        } else {
            selectedAccordIndex = tappedIndex
            showToolTip(for: sender, text: getAccordDescription(for: sender.tag))
            print(getAccordDescription(for: sender.tag))
        }


       
    }
    
    private func adjustScrollForTooltip(button: OptionButton, completion: @escaping () -> Void) {
        let buttonFrame = button.convert(button.bounds, to: accordScrollView)
        let scrollViewBounds = accordScrollView.bounds
        let tooltipWidth: CGFloat = 200
        let margin: CGFloat = 20
        
        // 현재 스크롤 위치에서 버튼의 절대 위치
        let buttonAbsoluteX = accordScrollView.contentOffset.x + buttonFrame.minX
        
        // 툴팁을 표시하기 위해 필요한 공간 계산
        let requiredRightSpace = buttonAbsoluteX + tooltipWidth + margin
        let requiredLeftSpace = buttonAbsoluteX - tooltipWidth - margin
        
        var targetOffsetX = accordScrollView.contentOffset.x
        
        // 오른쪽 공간이 충분한지 체크
        let visibleRightEdge = accordScrollView.contentOffset.x + scrollViewBounds.width
        
        if requiredRightSpace > visibleRightEdge {
            // 오른쪽 공간이 부족하면 왼쪽으로 스크롤
            targetOffsetX = requiredRightSpace - scrollViewBounds.width
        } else if requiredLeftSpace < accordScrollView.contentOffset.x && buttonAbsoluteX < accordScrollView.contentOffset.x + tooltipWidth {
            // 왼쪽 공간이 필요하면 오른쪽으로 스크롤
            targetOffsetX = max(0, requiredLeftSpace)
        }
        
        // 스크롤 범위 제한
        let maxOffsetX = max(0, accordScrollView.contentSize.width - scrollViewBounds.width)
        targetOffsetX = min(maxOffsetX, max(0, targetOffsetX))
        
        if abs(targetOffsetX - accordScrollView.contentOffset.x) > 1 {
            // 스크롤이 필요한 경우
            UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseInOut) {
                self.accordScrollView.setContentOffset(CGPoint(x: targetOffsetX, y: 0), animated: false)
            } completion: { _ in
                completion()
            }
        } else {
            // 스크롤이 필요없는 경우
            completion()
        }
    }
    

    
    private func showToolTip(for button: OptionButton, text: String) {
        currentTooltip?.removeFromSuperview()
        currentTooltip = nil
        
        let buttonFrame = button.convert(button.bounds, to: self.view)
        let screenWidth = self.view.bounds.width
        let requiredWidth: CGFloat = 200
        
        let rightMargin = screenWidth - buttonFrame.maxX
        
        // 항상 버튼 아래쪽, 오른쪽/왼쪽만 결정
        let toolTipDirection: TooltipDirection
        if rightMargin >= requiredWidth + 20 {
            toolTipDirection = .right  // 실제로는 "아래쪽 + 오른쪽 정렬"
            print("방향: 아래쪽 오른쪽 정렬")
        } else {
            toolTipDirection = .left   // 실제로는 "아래쪽 + 왼쪽 정렬"
            print("방향: 아래쪽 왼쪽 정렬")
        }
        
        let tooltip = createToolTip(text: text, direction: toolTipDirection)
        positionToolTip(tooltip, relativeTo: button, direction: toolTipDirection)
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
            
        default: break
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
    
    private func positionToolTip(_ tooltip: UIView, relativeTo button: OptionButton, direction: TooltipDirection) {
        self.view.addSubview(tooltip)
        currentTooltip = tooltip
        
        let buttonFrame = button.convert(button.bounds, to: self.view)
        
        tooltip.snp.makeConstraints {
            $0.width.equalTo(130)
            $0.height.equalTo(80)
            $0.top.equalTo(buttonFrame.maxY + 10)  // 항상 버튼 아래
            
            switch direction {
            case .right:  // 오른쪽 정렬 (꼬리가 왼쪽에)
                $0.leading.equalTo(buttonFrame.minX)  // 버튼 왼쪽 끝에 맞춤
                
            case .left:   // 왼쪽 정렬 (꼬리가 오른쪽에)
                $0.trailing.equalTo(buttonFrame.maxX)  // 버튼 오른쪽 끝에 맞춤
                
            default:
                break
            }
        }
        
        // 애니메이션은 동일
        tooltip.alpha = 0
        tooltip.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
        
        UIView.animate(withDuration: 0.3, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.8) {
            tooltip.alpha = 1
            tooltip.transform = .identity
        }
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
