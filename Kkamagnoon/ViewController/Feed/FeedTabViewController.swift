//
//  FeedTabViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit
import RxSwift
import RxCocoa

class FeedTabViewController: UITabBarController {
    
    var feedTabBar: FeedTabBar!
//    var selectedColor = UIColor.white
//    var selectedWeight = UIFont.Weight.bold
//    var normalColor = UIColor.lightGray {
//        didSet {
//            feedTabBar.tintColor = normalColor
//        }
//    }
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.isHidden = true
        setView()
    }
    
    func setView() {}
    
    func setTabBar(items: [FeedTabBarItem]) {
        feedTabBar = FeedTabBar(items: items)
        guard let bar = feedTabBar else { return }
        
        view.addSubview(bar)
        bar.topAnchor.constraint(equalTo: view.topAnchor, constant: 63).isActive = true
        bar.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20).isActive = true
        bar.heightAnchor.constraint(equalToConstant: 33).isActive = true
        bar.widthAnchor.constraint(equalToConstant: 200).isActive = true

        for idx in 0 ..< items.count {
            items[idx].tag = idx
            items[idx].rx.tap.bind { _ in
                self.selectedIndex = items[idx].tag
                items[idx].lock = true
                items[1-idx].lock = false
            }
            .disposed(by: disposeBag)
        }
    }
   
}
