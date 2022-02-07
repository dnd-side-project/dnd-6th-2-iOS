//
//  FeedTabBarItem.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit

class FeedTabBarItem: UIButton {

    var lock = false
//    var color: UIColor = UIColor.lightGray {
//        didSet {
//            guard lock == false else { return }
//        }
//    }
    
    convenience init(title: String,
                     font: UIFont = UIFont.systemFont(ofSize: 20, weight: .medium)) {
        self.init()
        translatesAutoresizingMaskIntoConstraints = false
        self.setTitle(title, for: .normal)
        self.titleLabel?.font = font
    }

}
