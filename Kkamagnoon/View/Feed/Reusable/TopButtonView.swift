//
//  TopButtonView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/11.
//

import UIKit
import RxSwift

class TopButtonView: UIView {

    let wholeFeedButton = UIButton()
    let subscribeButton = UIButton()

    let searchButton: UIButton = UIButton()
    let bellButton: UIButton = UIButton()

    let disposeBag = DisposeBag()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setTabButton()
        setBellButton()
        setSearchButton()
        setTabViewAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTabButton() {
        self.addSubview(wholeFeedButton)

        wholeFeedButton.setTitle(StringType.wholeFeed, for: .normal)
        wholeFeedButton.translatesAutoresizingMaskIntoConstraints = false

        wholeFeedButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)

        wholeFeedButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 63).isActive = true
        wholeFeedButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

        self.addSubview(subscribeButton)
        subscribeButton.translatesAutoresizingMaskIntoConstraints = false

        subscribeButton.setTitle(StringType.subscribeFeed, for: .normal)
        subscribeButton.setTitleColor(UIColor.gray, for: .normal)
        subscribeButton.titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)

        subscribeButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 63).isActive = true
        subscribeButton.leftAnchor.constraint(equalTo: wholeFeedButton.rightAnchor, constant: 10).isActive = true

    }

    func setBellButton() {
        self.addSubview(bellButton)
        bellButton.translatesAutoresizingMaskIntoConstraints = false

        bellButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        bellButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        bellButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 65).isActive = true
     }

     func setSearchButton() {

        self.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        searchButton.setImage(UIImage(systemName: "heart.fill"), for: .normal)

        searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 65).isActive = true
        searchButton.rightAnchor.constraint(equalTo: bellButton.leftAnchor, constant: -8).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
     }

    private func setTabViewAction() {
       let tabButtons = [wholeFeedButton, subscribeButton]

       for idx in 0 ..< tabButtons.count {
           tabButtons[idx].rx.tap
               .bind { _ in
                   if idx == 1 {
                       self.searchButton.isHidden = true
                   } else {
                       self.searchButton.isHidden = false
                   }
                   tabButtons[idx].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .bold)
                   tabButtons[idx].setTitleColor(.white, for: .normal)

                   tabButtons[1-idx].titleLabel?.font = UIFont.systemFont(ofSize: 20, weight: .medium)
                   tabButtons[1-idx].setTitleColor(.gray, for: .normal)
               }
               .disposed(by: disposeBag)
       }
    }
}
