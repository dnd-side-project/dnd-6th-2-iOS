//
//  Decode.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/13.
//

import Foundation

extension Decodable {
    static func decode<T: Decodable> (dictionary: [String: Any]) throws -> T {
        let data = try JSONSerialization.data(withJSONObject: dictionary, options: [.fragmentsAllowed])
        return try JSONDecoder().decode(T.self, from: data)
    }
}
