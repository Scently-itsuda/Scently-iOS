//
//  SocialViewController.swift
//  Scently
//
//  Created by 임재현 on 4/28/25.
//

import UIKit

final class SocialViewController: UIViewController {
    let socialView = SocialView()
    
    var tabbarViewModel = TabBarViewModel()
    
    override func loadView() {
        super.loadView()
        self.view = socialView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupCollectionViewDelegate()
        registerCell()
    }
}
private extension SocialViewController {
    func setupUI() {
        self.view.backgroundColor = .white
    }
    
    func setupCollectionViewDelegate() {
        socialView.tabbarView.collectionView.dataSource = self
        socialView.tabbarView.collectionView.delegate = self
    }
    
    func registerCell() {
        socialView.tabbarView.collectionView.register(TabBarCollectionViewCell.self, forCellWithReuseIdentifier: TabBarCollectionViewCell.reuseIdentifier)
    }
}

extension SocialViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return tabbarViewModel.socialTabbarList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TabBarCollectionViewCell.reuseIdentifier, for: indexPath) as? TabBarCollectionViewCell else {
            return UICollectionViewCell()
        }

        cell.titleLabel.text = tabbarViewModel.socialTabbarList[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = socialView.tabbarView.collectionView.frame.width
        let menuWidth = (width / 2) / 3
        
        let height = socialView.tabbarView.collectionView.frame.height
        
        return CGSize(width: menuWidth, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        print("TabbarCell Tapped")
    }
}
