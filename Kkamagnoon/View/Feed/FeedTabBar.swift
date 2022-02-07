//
//  FeedTabBar.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit

class FeedTabBar: UITabBar {

    var feedTabItems = [FeedTabBarItem]()

//    override var tintColor: UIColor! {
//        didSet {
//            for item in feedTabItems {
//                item.color = tintColor
//            }
//        }
//    }
    convenience init(items: [FeedTabBarItem]) {
        self.init()
        feedTabItems = items
        translatesAutoresizingMaskIntoConstraints = false
        setView()
    }
    
    func setView() {
        self.isTranslucent = false
        self.clipsToBounds = true
        
        self.addSubview(feedTabItems[0])
        
        feedTabItems[0].leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        feedTabItems[0].topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        if feedTabItems[0].lock == true {
            feedTabItems[0].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
        
        self.addSubview(feedTabItems[1])
        feedTabItems[1].leftAnchor.constraint(equalTo: feedTabItems[0].rightAnchor, constant: 12).isActive = true
        feedTabItems[1].topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        if feedTabItems[1].lock == true {
            feedTabItems[1].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
        }
    }
}
