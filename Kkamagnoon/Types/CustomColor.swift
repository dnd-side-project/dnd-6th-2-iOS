//
//  CustomColor.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/09.
//

import UIKit

struct Color {
    static let basicBackground = 0x191919
    static let tag = 0x292929
    static let tagText = 0x797979
    static let feedListCard = 0x202020
    static let content = 0xeaeaea

    static let whitePurple = 0xED5BF9
    static let tagGreen = 0x00DFAA
    static let cardBlue = 0x2F6AFF
    static let placeholder = 0x939393
}

enum ColorType: Int {

    // main color
    case mainPurple = 0xED5BF9
    case mainGreen = 0x00DFAA
    case mainBlue = 0x2F6AFF
//
//    // gray
    case backgroundGray = 0x191919
    case writingBoxGray = 0x292929
    case feedBoxGray = 0x202020
    case lineDarkGray = 0x2E2E2E
    case lineLightGray = 0x414141
//
    case subTextGray = 0x626262
    case tagTextGray = 0x767676
    case titleTabGray = 0x787878
//
//    // white
    case feedBoxWhite = 0xE2E2E2
    case writingBoxWhite = 0xEAEAEA

}
