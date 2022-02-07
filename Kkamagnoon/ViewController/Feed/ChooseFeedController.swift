//
//  ChooseFeedController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/07.
//

import UIKit

class ChooseFeedController: FeedTabViewController {

    override func setView() {
        let wholeFeed = FeedTabBarItem(title: StringType.wholeFeed)
        let subscribeFeed = FeedTabBarItem(title: StringType.subscribeFeed)

        setTabBar(items: [wholeFeed, subscribeFeed])

        viewControllers = [
            createNavigation(for: FeedViewController()),
            createNavigation(for: FeedViewController())
        ]
    }
    
    func createNavigation(for rootViewController: UIViewController) -> UIViewController {
        let navigationVC = UINavigationController(rootViewController: rootViewController)
        return navigationVC
    }
    
}
