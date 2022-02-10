//
//  TabBarViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//

import UIKit

class TabBarViewController: UITabBarController {

    static var tabbarHeight: CGFloat = 0
    override func viewDidLoad() {
        super.viewDidLoad()
        TabBarViewController.tabbarHeight = self.tabBar.frame.height
        createBarItems()
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override var prefersStatusBarHidden: Bool {
        return false
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
