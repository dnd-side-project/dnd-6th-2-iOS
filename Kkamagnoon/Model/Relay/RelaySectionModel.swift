//
//  RelaySectionModel.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/22.
//

import RxDataSources

struct RelaySection {
    var header: String
    var items: [Item]
}

extension RelaySection: SectionModelType {
    typealias Item = Relay

    init(original: RelaySection, items: [Relay]) {
        self = original
        self.items = items
    }

}
