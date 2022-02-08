//
//  TabCell2.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit

class SubscribeTabCell: UICollectionViewCell {

    lazy var feedView = SubscribeFeedView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setSubscribeFeedView()
    }
    
    func setSubscribeFeedView() {
        self.addSubview(feedView)
        feedView.translatesAutoresizingMaskIntoConstraints = false
        feedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 73).isActive = true
        feedView.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -TabBarViewController.tabbarHeight).isActive = true
        feedView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        feedView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
