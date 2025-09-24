//
//  BirthdayInputView.swift
//  Scently
//
//  Created by 임재현 on 6/19/25.
//

import UIKit
import SnapKit


final class BirthDateInputView: UIView {
    
    private let datePickerButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("0000.00.00", for: .normal)
        button.setTitleColor(.lightGray, for: .normal)
        button.titleLabel?.font = .pretendard(.regular, size: 16)
        button.backgroundColor = .white
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.gray3.cgColor
        button.layer.cornerRadius = 8
        button.contentHorizontalAlignment = .left
        button.contentEdgeInsets = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        return button
    }()
    
    private lazy var privateButton: OptionButton = {
        let button = OptionButton(title: "비공개")
        button.configure(font: .pretendard(.medium, size: 14), textColor: .gray3)
        return button
    }()
    
    private let stackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.spacing = 12
        stackView.alignment = .center
        stackView.distribution = .fill
        return stackView
    }()

    private var selectedDate: Date?
    private var isPrivate: Bool = false {
        didSet {
            updatePrivateState()
        }
    }
    
    private let dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        return formatter
    }()
    
    var onDateSelected: ((Date?) -> Void)?
    var onPrivateToggle: ((Bool) -> Void)?
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupLayout()
        setupActions()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupUI() {
        addSubview(stackView)
        stackView.addArrangedSubview(datePickerButton)
        stackView.addArrangedSubview(privateButton)
    }
    
    private func setupLayout() {
        stackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        datePickerButton.snp.makeConstraints {
            $0.height.equalTo(50)
        }
        
        privateButton.snp.makeConstraints {
            $0.width.equalTo(108)
            $0.height.equalTo(52)
        }
        datePickerButton.setContentHuggingPriority(.defaultHigh, for: .horizontal)
        privateButton.setContentHuggingPriority(.defaultLow, for: .horizontal)
    }
    
    private func setupActions() {
        datePickerButton.addTarget(self, action: #selector(datePickerButtonTapped), for: .touchUpInside)
        privateButton.addTarget(self, action: #selector(privateButtonTapped), for: .touchUpInside)
    }
    
    @objc private func datePickerButtonTapped() {
        // 비공개 상태일 때는 날짜 선택 불가
        guard !isPrivate else { return }
        
        showDatePicker()
    }
    
    @objc private func privateButtonTapped() {
        isPrivate.toggle()
        onPrivateToggle?(isPrivate)
    }

  private func showDatePicker() {
        guard let viewController = findViewController() else { return }
        
        let alert = UIAlertController(title: "생년월일 선택", message: "", preferredStyle: .alert)
        
        let datePicker = UIDatePicker()
        datePicker.datePickerMode = .date
        datePicker.preferredDatePickerStyle = .wheels
        datePicker.locale = Locale(identifier: "ko_KR")
        
        let calendar = Calendar.current
        datePicker.minimumDate = calendar.date(from: DateComponents(year: 1900, month: 1, day: 1))
        datePicker.maximumDate = Date()
        
        if let selectedDate = selectedDate {
            datePicker.date = selectedDate
        }
        
        // 안전한 방식으로 DatePicker 추가
        let containerViewController = UIViewController()
        containerViewController.view = datePicker
        alert.setValue(containerViewController, forKey: "contentViewController")
        
        let selectAction = UIAlertAction(title: "선택", style: .default) { [weak self] _ in
            self?.updateSelectedDate(datePicker.date)
        }
        
        let cancelAction = UIAlertAction(title: "취소", style: .cancel)
        
        alert.addAction(selectAction)
        alert.addAction(cancelAction)
        
        viewController.present(alert, animated: true)
    }

    private func updateSelectedDate(_ date: Date) {
        selectedDate = date
        let formattedDate = dateFormatter.string(from: date)
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        datePickerButton.setTitle(formattedDate, for: .normal)
        datePickerButton.setTitleColor(.black, for: .normal)
        datePickerButton.titleLabel?.font = .pretendard(.medium, size: 16)
        
        CATransaction.commit()
        
        onDateSelected?(date)
    }

    private func resetDate() {
        selectedDate = nil
        
        CATransaction.begin()
        CATransaction.setDisableActions(true)
        
        datePickerButton.setTitle("0000.00.00", for: .normal)
        datePickerButton.setTitleColor(.lightGray, for: .normal)
        datePickerButton.titleLabel?.font = .pretendard(.regular, size: 16)
        
        CATransaction.commit()
        
        onDateSelected?(nil)
    }
    
    private func updatePrivateState() {
        if isPrivate {
            privateButton.updateSelectedState(isSelected: true)
            resetDate()
            datePickerButton.isEnabled = false
            datePickerButton.alpha = 0.5
            
        } else {
            privateButton.updateSelectedState(isSelected: false)
            datePickerButton.isEnabled = true
            datePickerButton.alpha = 1.0
        }
    }
}

// MARK: - Public Methods
extension BirthDateInputView {
    
    func getSelectedDate() -> Date? {
        return isPrivate ? nil : selectedDate
    }
    
    func setSelectedDate(_ date: Date?) {
        if let date = date {
            isPrivate = false
            updateSelectedDate(date)
        } else {
            resetDate()
        }
    }
    
    func setPrivate(_ private: Bool) {
        isPrivate = `private`
    }
    
    func isDatePrivate() -> Bool {
        return isPrivate
    }
    
    func reset() {
        isPrivate = false
        resetDate()
    }
}

// MARK: - UIResponder Extension
extension UIResponder {
    func findViewController() -> UIViewController? {
        if let viewController = self as? UIViewController {
            return viewController
        }
        return next?.findViewController()
    }
}
