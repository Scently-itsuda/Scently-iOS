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
        
        return cell
    }
}
