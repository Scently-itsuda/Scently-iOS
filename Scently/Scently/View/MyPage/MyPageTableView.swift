//
//  MyPageTableView.swift
//  Scently
//
//  Created by 임재현 on 8/16/25.
//

import UIKit
import SnapKit

final class MyPageTableView: UIView {
    
    private let menuTitles = [
         "알림 설정",
         "제품 등록 요청",
         "공지사항",
         "피드백 보내기",
         "로그아웃"
     ]
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.backgroundColor = .white
        tableView.separatorStyle = .none
        tableView.showsVerticalScrollIndicator = false
        tableView.isScrollEnabled = false
        
        tableView.register(MyPageSettingsCell.self, forCellReuseIdentifier: MyPageSettingsCell.reuseIdentifier)
        
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

extension MyPageTableView {
    
    private func setupUI() {
        self.addSubviews(tableView)
    }
    private func setupConstraints() {
        tableView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
    }
    
    private func setupTableView() {
        tableView.delegate = self
        tableView.dataSource = self
    }
}


extension MyPageTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return menuTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: MyPageSettingsCell.reuseIdentifier, for: indexPath) as? MyPageSettingsCell else {
            return UITableViewCell()
        }
        
        cell.configure(title: menuTitles[indexPath.row])
        
        return cell
    }
}

extension MyPageTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedTitle = menuTitles[indexPath.row]
        print("선택된 메뉴: \(selectedTitle)")
    }
}
