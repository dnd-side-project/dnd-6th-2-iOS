//
//  TopButtonView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/11.
//

import UIKit
import RxSwift

class TopButtonView: UIView {

    let firstButton = UIButton()
    let secondButton = UIButton()

    let searchButton: UIButton = UIButton()
    let bellButton: UIButton = UIButton()

    let disposeBag = DisposeBag()

    init(frame: CGRect, first: String, second: String) {
        super.init(frame: frame)
        setTabButton(first: first, second: second)
        setBellButton()
        setSearchButton()
        setTabViewAction()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setTabButton(first: String, second: String) {
        self.addSubview(firstButton)

        firstButton.setTitle(first, for: .normal)
        firstButton.translatesAutoresizingMaskIntoConstraints = false

        firstButton.titleLabel?.font = UIFont.pretendard(weight: .semibold, size: 20)

        firstButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 63).isActive = true
        firstButton.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 20).isActive = true

        self.addSubview(secondButton)
        secondButton.translatesAutoresizingMaskIntoConstraints = false

        secondButton.setTitle(second, for: .normal)
        secondButton.setTitleColor(UIColor.gray, for: .normal)
        secondButton.titleLabel?.font = UIFont.pretendard(weight: .medium, size: 20)

        secondButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 63).isActive = true
        secondButton.leftAnchor.constraint(equalTo: firstButton.rightAnchor, constant: 17).isActive = true

    }

    func setBellButton() {
        self.addSubview(bellButton)
        bellButton.translatesAutoresizingMaskIntoConstraints = false

        bellButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -20).isActive = true
        bellButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
        bellButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 65).isActive = true
     }

     func setSearchButton() {

        self.addSubview(searchButton)
        searchButton.translatesAutoresizingMaskIntoConstraints = false

        searchButton.topAnchor.constraint(equalTo: self.topAnchor, constant: 65).isActive = true
        searchButton.rightAnchor.constraint(equalTo: bellButton.leftAnchor, constant: -8).isActive = true
        searchButton.widthAnchor.constraint(equalToConstant: 28).isActive = true
        searchButton.heightAnchor.constraint(equalToConstant: 28).isActive = true
     }

    private func setTabViewAction() {
       let tabButtons = [firstButton, secondButton]

       for idx in 0 ..< tabButtons.count {
           tabButtons[idx].rx.tap
               .bind { _ in
                   tabButtons[idx].titleLabel?.font = UIFont.pretendard(weight: .bold, size: 20)
                   tabButtons[idx].setTitleColor(.white, for: .normal)

                   tabButtons[1-idx].titleLabel?.font = UIFont.pretendard(weight: .medium, size: 20)
                   tabButtons[1-idx].setTitleColor(.gray, for: .normal)
               }
               .disposed(by: disposeBag)
       }
    }
}
