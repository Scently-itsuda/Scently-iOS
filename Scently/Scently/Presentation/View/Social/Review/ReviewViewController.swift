//
//  ReviewViewController.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit

final class ReviewViewController: UIViewController {
    lazy var reviewTableView: UITableView = {
        let tableView = UITableView()
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraint()
        setupTableView()
    }
}

extension ReviewViewController {
    func setupUI() {
        self.view.addSubview(reviewTableView)
    }
    
    func setupConstraint() {
        reviewTableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    func setupTableView() {
        reviewTableView.delegate = self
        reviewTableView.dataSource = self
        
        reviewTableView.register(ReviewListTableViewCell.self, forCellReuseIdentifier: ReviewListTableViewCell.reuseIdentifier)
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ReviewListTableViewCell.reuseIdentifier, for: indexPath) as? ReviewListTableViewCell else {
            return UITableViewCell()
        }
        
        cell.delegate = self
        
        return cell
    }
}

extension ReviewViewController: ReviewCellDelegate {
    
    func moreButtonTapped(isMyReview: Bool) {
        let myReviewSheet = ReviewActionBottomSheetViewController(isMyReview: isMyReview)
        
        myReviewSheet.onReportTapped = { [weak self] in
            self?.showReportReasonSheet()
        }
        
        myReviewSheet.onEditTapped = { [weak self] in
            print("수정하기")
            // TODO: 수정 로직
        }
        
        myReviewSheet.onDeleteTapped = { [weak self] in
            print("삭제하기")
            // TODO: 삭제 로직
        }
        
        
        myReviewSheet.modalPresentationStyle = .overFullScreen
        myReviewSheet.modalTransitionStyle = .crossDissolve
        present(myReviewSheet, animated: true)
    }
    

    private func showReportReasonSheet() {
        let sheet = ReportReasonBottomSheetViewController()
        
        sheet.onReasonSelected = { [weak self] reason in //
            if reason == .other { // 또는 reason.needsDetail
                // "기타" 선택 → 텍스트 입력 필요
                self?.showReportTextInput(reason: reason)
            } else {
                // 바로 신고 제출
               // self?.submitReport(reason: reason, detail: nil)
            }
        }
        
        sheet.modalPresentationStyle = .overCurrentContext
        sheet.modalTransitionStyle = .crossDissolve
        present(sheet, animated: true)
    }
    private func showReportTextInput(reason: ReportReason) {
//         let sheet = ReportTextInputBottomSheetViewController(reason: reason)
//         
//         sheet.onSubmit = { [weak self] detail in
//             self?.submitReport(reason: reason, detail: detail)
//         }
//         
//         sheet.modalPresentationStyle = .overFullScreen
//         present(sheet, animated: true)
     }
     
     private func submitReport(reason: ReportReason, detail: String?) {
         print("신고 제출 - 사유: \(reason.rawValue), 상세: \(detail ?? "없음")")
         // TODO: API 호출
         dismiss(animated: true) {
             // 신고 완료 알림 등
         }
     }
}

enum ReportReason: String {
    case spam = "스팸, 광고"
    case badWords = "욕설, 인신공격 등의 부적절한 발언"
    case sexual = "음란성, 선정성 글"
    case repetitive = "반복적인 글 게재"
    case personalInfo = "개인정보 등 민감정보 노출"
    case other = "기타"
    
    var needsDetail: Bool {
        return self == .other
    }
}
