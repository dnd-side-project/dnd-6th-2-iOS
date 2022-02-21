//
//  RelayCellDataModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation
import RxDataSources

struct CustomData {
  var anInt: Int
  var aString: String
  var aCGPoint: CGPoint
}

struct SectionOfCustomData {
  var header: String
  var items: [Item]
}

extension SectionOfCustomData: SectionModelType {
  typealias Item = CustomData

   init(original: SectionOfCustomData, items: [Item]) {
    self = original
    self.items = items
  }
}
