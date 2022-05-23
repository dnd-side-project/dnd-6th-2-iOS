//
//  Color.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import UIKit

enum Colors {
    case mainPurple
    case mainGreen
    case mainBlue
    case backgroundGray
    case writingBoxGray
    case feedBoxGray
    case lineDarkGray
    case lineLightGray
    case subTextGray
    case tagTextGray
    case titleTabGray
    case scrapBoxGray
    case feedBoxWhite
    case writingBoxWhite
    case gray_1
    case alertBoxGray
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

    convenience init(rgb: Int, alpha: CGFloat) {
        self.init(
            red: CGFloat((rgb >> 16) & 0xFF),
            green: CGFloat((rgb >> 8) & 0xFF),
            blue: CGFloat(rgb & 0xFF),
            alpha: alpha
        )
    }
}

extension UIColor {
    static func appColor(_ name: Colors) -> UIColor {
        switch name {

        // main color
        case .mainPurple:
            return UIColor(rgb: 0xED5BF9)

        case .mainGreen:
            return UIColor(rgb: 0x00DFAA)

        case .mainBlue:
            return UIColor(rgb: 0x2F6AFF)
        // gray
        case .backgroundGray:
            return UIColor(rgb: 0x191919)

        case .writingBoxGray:
            return UIColor(rgb: 0x292929)

        case .feedBoxGray:
            return UIColor(rgb: 0x202020)

        case .lineDarkGray:
            return UIColor(rgb: 0x2E2E2E)

        case .lineLightGray:
            return UIColor(rgb: 0x414141)

        case .subTextGray:
            return UIColor(rgb: 0x626262)

        case .tagTextGray:
            return UIColor(rgb: 0x767676)

        case .titleTabGray:
            return UIColor(rgb: 0x787878)

        case .scrapBoxGray:
            return UIColor(rgb: 0x282828)

        // white
        case .feedBoxWhite:
            return UIColor(rgb: 0xE2E2E2)

        case .writingBoxWhite:
            return UIColor(rgb: 0xEAEAEA)

        case .gray_1:
            return UIColor(rgb: 0xDFDFDF)

        case .alertBoxGray:
            return UIColor(rgb: 0x313131)
        }
    }
}
