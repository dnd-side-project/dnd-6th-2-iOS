//
//  View.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

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

extension UIView {
   func roundCorners(corners: UIRectCorner, radius: CGFloat) {
        let path = UIBezierPath(roundedRect: bounds, byRoundingCorners: corners, cornerRadii: CGSize(width: radius, height: radius))
        let mask = CAShapeLayer()
        mask.path = path.cgPath
        layer.mask = mask
    }
}

extension UIView {
    enum ViewSide: String {
        case left = "Left", right = "Right", top = "Top", bottom = "Bottom"
    }

    func addBorder(toSide side: ViewSide, withColor color: CGColor, andThickness thickness: CGFloat) {

        let border = CALayer()
        border.borderColor = color
        border.name = side.rawValue
        switch side {
        case .left: border.frame = CGRect(x: 0, y: 0, width: thickness, height: frame.height)
        case .right: border.frame = CGRect(x: frame.width - thickness, y: 0, width: thickness, height: frame.height)
        case .top: border.frame = CGRect(x: 0, y: 0, width: frame.width, height: thickness)
        case .bottom: border.frame = CGRect(x: 0, y: frame.height - thickness, width: frame.width, height: thickness)
        }

        border.borderWidth = thickness

        layer.addSublayer(border)
    }

    func removeBorder(toSide side: ViewSide) {
        guard let sublayers = self.layer.sublayers else { return }
        var layerForRemove: CALayer?
        for layer in sublayers {
            if layer.name == side.rawValue {
                layerForRemove = layer
            }
        }
        if let layer = layerForRemove {
            layer.removeFromSuperlayer()
        }
    }
}
