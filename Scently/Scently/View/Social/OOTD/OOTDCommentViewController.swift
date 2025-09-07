//
//  OOTDCommentViewController.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

final class OOTDCommentViewController: UIViewController {
    private var headerView = OOTDCommentHeaderView()
    private var commentListView = CommentListView()
    private var commentTextView = CommentTextView()
    
    private var commentTextViewBottomConstraint: Constraint?
    
//    let mockComments = CommentResponse.mockData

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupConstraints()
        configureComments()
        setupKeyboardObservers()
        setupTapGesture()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        removeKeyboardObservers()
    }
}

extension OOTDCommentViewController {
    private func setupUI() {
        self.view.backgroundColor = .white
        self.view.addSubviews(headerView,commentListView,commentTextView)
        
    }
    private func setupConstraints() {
        headerView.snp.makeConstraints {
            $0.top.equalTo(self.view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        commentListView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(16)
            $0.leading.trailing.equalToSuperview()
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
        }
        
        commentTextView.snp.makeConstraints {
            $0.top.equalTo(commentListView.snp.bottom).offset(10)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(36)
            self.commentTextViewBottomConstraint = $0.bottom.equalTo(view.safeAreaLayoutGuide.snp.bottom).constraint
//            $0.bottom.equalTo(self.view.safeAreaLayoutGuide).offset(-16)
        }
    }
    
    private func configureComments() {
//        commentListView.configure(with: mockComments)
    }
    
    private func setupKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    private func removeKeyboardObservers() {
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillShowNotification, object: nil)
         NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
     }
    
    @objc
    private func keyboardWillShow(_ notification: Notification) {
        guard let keyboardFrame = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? CGRect,
              let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        let keyboardHeight = keyboardFrame.height
        
        // CommentTextView를 키보드 높이만큼 위로 올리기
        commentTextViewBottomConstraint?.update(offset: -keyboardHeight)
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
    
    @objc
    private func keyboardWillHide(_ notification: Notification) {
        guard let animationDuration = notification.userInfo?[UIResponder.keyboardAnimationDurationUserInfoKey] as? Double else {
            return
        }
        
        // CommentTextView를 원래 위치로 복원
        commentTextViewBottomConstraint?.update(offset: 0)
        
        UIView.animate(withDuration: animationDuration) {
            self.view.layoutIfNeeded()
        }
    }
}

extension OOTDCommentViewController: UIGestureRecognizerDelegate {
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldReceive touch: UITouch) -> Bool {
        // CommentTextView 영역을 탭했을 때는 키보드를 내리지 않도록
        let touchLocation = touch.location(in: view)
        let commentTextViewFrame = commentTextView.frame
        
        return !commentTextViewFrame.contains(touchLocation)
    }
    
    private func setupTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(dismissKeyboard))
        tapGesture.cancelsTouchesInView = false
        tapGesture.delegate = self
        view.addGestureRecognizer(tapGesture)
    }

    @objc private func dismissKeyboard() {
        view.endEditing(true)
    }
}
    
    
    

