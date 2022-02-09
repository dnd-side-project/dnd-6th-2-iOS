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

extension UIColor {
   convenience init(red: Int, green: Int, blue: Int) {
       assert(red >= 0 && red <= 255, "Invalid red component")
       assert(green >= 0 && green <= 255, "Invalid green component")
       assert(blue >= 0 && blue <= 255, "Invalid blue component")

       self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
   }

   convenience init(rgb: Int) {
       self.init(
           red: (rgb >> 16) & 0xFF,
           green: (rgb >> 8) & 0xFF,
           blue: rgb & 0xFF
       )
   }
    
}

extension String {
    func substring(from: Int, to: Int) -> String {
        guard from < count, to >= 0, to - from >= 0 else {
            return ""
        }
        
        let startIndex = index(self.startIndex, offsetBy: from)
        let endIndex = index(self.startIndex, offsetBy: to + 1)
        
        return String(self[startIndex ..< endIndex])
    }
}

extension UINavigationController {
    
    open override var childForStatusBarHidden: UIViewController? {
        return viewControllers.last
    }
    
    open override var childForStatusBarStyle: UIViewController? {
        return viewControllers.last
    }
}

extension UITabBarController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.children.first
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.children.first
    }
}

extension UISplitViewController {
    
    open override var childForStatusBarStyle: UIViewController? {
        return self.children.first
    }
    
    open override var childForStatusBarHidden: UIViewController? {
        return self.children.first
    }
}

//extension CALayer {
//    func addBorder(_ edgeArr: [UIRectEdge], color: UIColor, width: CGFloat) {
//        for edge in edgeArr {
//            let border = CALayer()
//            switch edge {
//                case UIRectEdge.top:
//                border.frame = CGRect.init(x: 0, y: 0, width: frame.width, height: width)
//                break
//                
//                case UIRectEdge.bottom:
//                border.frame = CGRect.init(x: 0, y: frame.height - width, width: frame.width, height: width)
//                break
//                
//                case UIRectEdge.left:
//                border.frame = CGRect.init(x: 0, y: 0, width: width, height: frame.height)
//                break
//                
//                case UIRectEdge.right:
//                border.frame = CGRect.init(x: frame.width - width, y: 0, width: width, height: frame.height)
//                break
//                
//                default:
//                break
//                
//            }
//            border.backgroundColor = color.cgColor;
//            self.addSublayer(border)
//        }
//    }
//}
//
//struct BorderOptions: OptionSet {
//    let rawValue: Int
//
//    static let top = BorderOptions(rawValue: 1 << 0)
//    static let left = BorderOptions(rawValue: 1 << 1)
//    static let bottom = BorderOptions(rawValue: 1 << 2)
//    static let right = BorderOptions(rawValue: 1 << 3)
//    
//    static let horizontal: BorderOptions = [.left, .right]
//    static let vertical: BorderOptions = [.top, .bottom]
//}

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
