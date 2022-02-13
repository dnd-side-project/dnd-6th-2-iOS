//
//  TabBarViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit
import SnapKit

class TabBarViewController: UITabBarController {

    static var tabbarHeight: CGFloat = 0

    var grayLine = GrayBorderView()
    override func viewDidLoad() {
        super.viewDidLoad()
        TabBarViewController.tabbarHeight = self.tabBar.frame.height
        createBarItems()

        setGrayLine()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return false
    }

    func setGrayLine() {
        tabBar.addSubview(grayLine)

        grayLine.backgroundColor = UIColor(rgb: 0x323232)

        grayLine.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(tabBar.snp.top).offset(-0.5)
        }

    }

    func createBarItems() {
        viewControllers = [
            createNavController(for: ChallengeViewController(),
                                   title: StringType.challenge,
                                   image: UIImage(systemName: "heart.fill")!),
            createNavController(for: MyWritingViewController(),
                                   title: StringType.myWriting,
                                   image: UIImage(systemName: "heart.fill")!),
            createNavController(for: FeedViewController(),
                                   title: StringType.feed,
                                   image: UIImage(systemName: "heart.fill")!),
            createNavController(for: RelayViewController(),
                                   title: StringType.relay,
                                   image: UIImage(systemName: "heart.fill")!),
            createNavController(for: MyPageViewController(),
                                   title: StringType.myPage,
                                   image: UIImage(systemName: "heart.fill")!)
        ]
    }

    func createNavController(for rootViewController: UIViewController,
                             title: String,
                             image: UIImage) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        navigationVC.tabBarItem.title = title
        navigationVC.tabBarItem.image = image
        return navigationVC
    }

}
