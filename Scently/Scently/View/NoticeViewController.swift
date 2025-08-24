//
//  NoticeViewController.swift
//  Scently
//
//  Created by 임재현 on 8/24/25.
//

import UIKit
import SnapKit

final class NoticeViewController: UIViewController {
    
    private var profileEditNavigationView = ProfileEditNavigationView()
    
    private let noticetableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .red
        tableView.isScrollEnabled = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .white
        setupUI()
        setupConstraints()
        setupTableView()
        profileEditNavigationView.delegate = self
    }
}

extension NoticeViewController {
    private func setupUI(){
        self.view.addSubviews(noticetableView,profileEditNavigationView)
        profileEditNavigationView.configure(title: "공지사항")
    }
    private func setupConstraints(){
        
        profileEditNavigationView.snp.makeConstraints {
            $0.top.equalTo(view.safeAreaLayoutGuide)
            $0.leading.trailing.equalToSuperview()
            $0.height.equalTo(60)
        }
        
        noticetableView.snp.makeConstraints {
            $0.top.equalTo(profileEditNavigationView.snp.bottom).offset(16)
            $0.leading.trailing.bottom.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        noticetableView.dataSource = self
        noticetableView.delegate = self
        noticetableView.allowsSelection = true
        noticetableView.estimatedRowHeight = 60
        noticetableView.rowHeight = UITableView.automaticDimension
        noticetableView.backgroundColor = .white
//        freeBoardtableView.isScrollEnabled = false
        noticetableView.register(NoticeTableViewCell.self, forCellReuseIdentifier: NoticeTableViewCell.reuseIdentifier)
        
        
        noticetableView.separatorStyle = .singleLine
        noticetableView.separatorColor = .lightgray
        noticetableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension NoticeViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NoticeTableViewCell.reuseIdentifier, for: indexPath) as? NoticeTableViewCell else {return UITableViewCell()}
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      

    }
}

extension NoticeViewController: ProfileEditNavigationViewDelegate {
    func profileEditButtonDidTap() {
        navigationController?.popViewController(animated: true)
    }
}
