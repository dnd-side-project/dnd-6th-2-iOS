//
//  NewFeedViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit
import RxSwift
import RxCocoa

class FeedViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    lazy var wholeFeedButton = UIButton()
    lazy var subscribeButton = UIButton()
    
    var tabCollectionView: UICollectionView!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        bindChooseFeedButton()
        bindTabCollectionView()
    }
    
    func bindChooseFeedButton() {
        wholeFeedButton.setTitle(StringType.wholeFeed, for: .normal)
        wholeFeedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        view.addSubview(wholeFeedButton)
        wholeFeedButton.translatesAutoresizingMaskIntoConstraints = false
        wholeFeedButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        wholeFeedButton.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        
        subscribeButton.setTitle(StringType.subscribeFeed, for: .normal)
        subscribeButton.setTitleColor(UIColor.gray, for: .normal)
        subscribeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        view.addSubview(subscribeButton)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false
        subscribeButton.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        subscribeButton.leftAnchor.constraint(equalTo: wholeFeedButton.rightAnchor, constant: 10).isActive = true
        
        let tabButtons = [wholeFeedButton, subscribeButton]
                
        for idx in 0 ..< tabButtons.count {
            tabButtons[idx].rx.tap
                .bind { _ in
                    tabButtons[idx].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                    tabButtons[idx].setTitleColor(.white, for: .normal)
                    
                    tabButtons[1-idx].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                    tabButtons[1-idx].setTitleColor(.gray, for: .normal)
                    
                    self.tabCollectionView.scrollToItem(at: IndexPath(item: idx, section: 0), at: .centeredHorizontally, animated: false)
                }
                .disposed(by: disposeBag)
        }
    }

    
    func bindTabCollectionView() {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 0
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: .zero)
        layout.itemSize.width = view.frame.width
        layout.itemSize.height = view.frame.height
        
        tabCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        tabCollectionView.register(WholeTabCell.self, forCellWithReuseIdentifier: CellIdentifier.wholeTab)
        tabCollectionView.register(SubscribeTabCell.self, forCellWithReuseIdentifier: CellIdentifier.subscribeTab)
        
        tabCollectionView.showsHorizontalScrollIndicator = false
        
        tabCollectionView.isPagingEnabled = false
        tabCollectionView.isScrollEnabled = false
        tabCollectionView.backgroundColor = .none
        tabCollectionView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(tabCollectionView)
        
        tabCollectionView.topAnchor.constraint(equalTo: wholeFeedButton.bottomAnchor, constant: 10).isActive = true
        tabCollectionView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        tabCollectionView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        tabCollectionView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        
        Observable<[String]>.of(["1", "2"])
            .bind(to: tabCollectionView.rx.items) { (collectionView, row, element) in
                let indexPath = IndexPath(row: row, section: 0)
                var cell: UICollectionViewCell
                if indexPath.item == 0 {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.wholeTab, for: indexPath)
                } else {
                    cell = collectionView.dequeueReusableCell(withReuseIdentifier: CellIdentifier.subscribeTab, for: indexPath)
                }
                return cell
            }
            .disposed(by: disposeBag)
    }

}
