//
//  CommentListView.swift
//  Scently
//
//  Created by 임재현 on 8/10/25.
//

import UIKit
import SnapKit

enum CommentType {
    case parent(CommentInfo)
    case child(ChildCommentInfo)
}

struct CommentDisplayItem {
    let type: CommentType
    let isChild: Bool
}

final class CommentListView: UIView {
    
    private var displayItems: [CommentDisplayItem] = []
    
    private let tableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .clear
        tableView.isScrollEnabled = true
        return tableView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
        setupConstraints()
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CommentListView {
    private func setupUI() {
        self.addSubviews(tableView)
        
        
    }
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
     func configure(with commentResponse: CommentResponse) {
        guard let data = commentResponse.data else {return}
        
        displayItems.removeAll()
        
        for commentInfo in data.commentInfos {
            displayItems.append(CommentDisplayItem(type: .parent(commentInfo), isChild: false))
            
            for childComment in commentInfo.childCommentInfos {
                displayItems.append(CommentDisplayItem(type: .child(childComment), isChild: true))
            }
        }
        
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.register(CommentTableViewCell.self, forCellReuseIdentifier: CommentTableViewCell.reuseIdentifier)
        
        tableView.separatorStyle = .singleLine
        tableView.separatorColor = .lightgray
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
    }
}

extension CommentListView: UITableViewDelegate, UITableViewDataSource {
    func tableView(
        _ tableView: UITableView,
        numberOfRowsInSection section: Int
    ) -> Int {
        return displayItems.count
    }
    
    func tableView(
        _ tableView: UITableView,
        cellForRowAt indexPath: IndexPath
    ) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(
            withIdentifier: CommentTableViewCell.reuseIdentifier,
            for: indexPath
        ) as? CommentTableViewCell else{
            return UITableViewCell()
        }
        
        let item = displayItems[indexPath.row]
        cell.configure(with: item)
        return cell
    }
    
    func tableView(
        _ tableView: UITableView,
        heightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func tableView(
        _ tableView: UITableView,
        estimatedHeightForRowAt indexPath: IndexPath
    ) -> CGFloat {
        return 80 // 예상 높이
    }
}
