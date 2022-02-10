//
//  TabCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import UIKit

class WholeTabCell: UICollectionViewCell {

    lazy var feedView = WholeFeedView()

    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = .black
        setWholeFeedView()
    }

    func setWholeFeedView() {
        self.addSubview(feedView)
        feedView.translatesAutoresizingMaskIntoConstraints = false
        feedView.topAnchor.constraint(equalTo: self.topAnchor, constant: 115).isActive = true
        feedView.bottomAnchor.constraint(equalTo: self.safeAreaLayoutGuide.bottomAnchor).isActive = true
        feedView.leftAnchor.constraint(equalTo: self.leftAnchor).isActive = true
        feedView.rightAnchor.constraint(equalTo: self.rightAnchor).isActive = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
