//
//  Navigation.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import UIKit

extension UINavigationController {
    func popViewController(animated: Bool, completion:@escaping (() -> Void)) -> UIViewController? {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        let poppedViewController = self.popViewController(animated: animated)
        CATransaction.commit()
        return poppedViewController
    }

    func pushViewController(_ viewController: UIViewController, animated: Bool, completion:@escaping (() -> Void)) {
        CATransaction.setCompletionBlock(completion)
        CATransaction.begin()
        self.pushViewController(viewController, animated: animated)
        CATransaction.commit()
    }
}
