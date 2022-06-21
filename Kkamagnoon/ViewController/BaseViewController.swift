//
//  BaseViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/06/20.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    func showError(_ e: Error) {

        guard let e = e as? NetworkError else {
            return
        }
        
        if e.isUnauthorizedError {
            //refreshToken
        } else {
            ErrorAlertPopup.showIn(viewController: self, message: e.errorDescription, subMessage: e.errorDescriptionDetail)
        }
    }

}
