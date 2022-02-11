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

    let topButtonView = TopButtonView()

    let wholeFeedView = WholeFeedView()
    let subscribeFeedView = SubscribeFeedView()

    var feedView: FeedView!

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        feedView = wholeFeedView
        setTopView()
        setFeedView()
        bindTopView()
    }

    func setTopView() {
        view.addSubview(topButtonView)
        topButtonView.translatesAutoresizingMaskIntoConstraints = false

        topButtonView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        topButtonView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        topButtonView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true
        topButtonView.heightAnchor.constraint(equalToConstant: 115).isActive = true
    }

    func setFeedView() {
        view.addSubview(feedView)
        feedView.translatesAutoresizingMaskIntoConstraints = false

        feedView.topAnchor.constraint(equalTo: topButtonView.bottomAnchor).isActive = true
        feedView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor).isActive = true
        feedView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        feedView.rightAnchor.constraint(equalTo: view.rightAnchor).isActive = true

    }

    func bindTopView() {

        topButtonView.wholeFeedButton.rx.tap
            .bind { _ in
                self.feedView.removeFromSuperview()
                self.feedView = self.wholeFeedView
                self.setFeedView()

            }
            .disposed(by: disposeBag)

        topButtonView.subscribeButton.rx.tap
            .bind { _ in
                self.feedView.removeFromSuperview()
                self.feedView = self.subscribeFeedView
                self.setFeedView()
            }
            .disposed(by: disposeBag)
    }

}
