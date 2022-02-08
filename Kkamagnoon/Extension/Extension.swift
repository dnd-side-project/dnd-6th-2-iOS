//
//  extension.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import Foundation
import UIKit

extension UIView {
  // 뷰컨트롤러 찾기
  var viewController: UIViewController? {
    if let vc = self.next as? UIViewController {
      return vc
    } else if let superView = self.superview {
      return superView.viewController
    } else {
      return nil
    }
  }
}
