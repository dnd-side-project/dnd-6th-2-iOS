//
//  FeedSectionModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import Foundation
import RxDataSources

struct FeedSection {
    var header: Relay
    var items: [Item]
}

extension FeedSection: SectionModelType {
    typealias Item = Article

    init(original: FeedSection, items: [Article]) {
        self = original
        self.items = items
    }

}
