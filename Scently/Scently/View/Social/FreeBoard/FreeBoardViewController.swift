//
//  FreeBoardViewController.swift
//  Scently
//
//  Created by sy0201 on 7/20/25.
//

import UIKit
import SnapKit

final class FreeBoardViewController: UIViewController {
    
    private let freeBoardtableView: UITableView = {
       let tableView = UITableView()
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.backgroundColor = .red
        tableView.isScrollEnabled = true
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = .systemBlue
        setupUI()
        setupConstraints()
        setupTableView()
    }
}

extension FreeBoardViewController {
    private func setupUI(){
        self.view.addSubviews(freeBoardtableView)
    }
    private func setupConstraints(){
        freeBoardtableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        freeBoardtableView.dataSource = self
        freeBoardtableView.delegate = self
        freeBoardtableView.allowsSelection = false
        freeBoardtableView.estimatedRowHeight = 60
        freeBoardtableView.rowHeight = UITableView.automaticDimension
        freeBoardtableView.backgroundColor = .white
//        freeBoardtableView.isScrollEnabled = false
        freeBoardtableView.register(FreeBoardTableViewCell.self, forCellReuseIdentifier: FreeBoardTableViewCell.reuseIdentifier)
        
        
        freeBoardtableView.separatorStyle = .singleLine
        freeBoardtableView.separatorColor = .lightgray
        freeBoardtableView.separatorInset = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)
    }
}

extension FreeBoardViewController: UITableViewDelegate, UITableViewDataSource {
   
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: FreeBoardTableViewCell.reuseIdentifier, for: indexPath) as? FreeBoardTableViewCell else {return UITableViewCell()}
        
        return cell
    }
}
