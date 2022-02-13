//
//  FlexibleDecode.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/08.
//

import Foundation

@propertyWrapper struct FlexibleField<T: FlexibleDecodable>: Decodable {
 var wrappedValue: T?

 init(from decoder: Decoder) {
  wrappedValue = try? T(container: decoder.singleValueContainer())
 }
}

protocol FlexibleDecodable {
 init(container: SingleValueDecodingContainer) throws
}

extension Int: FlexibleDecodable {
 init(container: SingleValueDecodingContainer) throws {
  if let int = try? container.decode(Int.self) {
   self = int
  } else if let string = try? container.decode(String.self), let int = Int(string) {
   self = int
  } else {
   throw DecodingError
    .dataCorrupted(.init(codingPath: container.codingPath,
               debugDescription: "Invalid int value"))
  }
 }
}

extension String: FlexibleDecodable {
 init(container: SingleValueDecodingContainer) throws {
  if let int = try? container.decode(Int.self) {
   self = String(int)
  } else if let string = try? container.decode(String.self) {
   self = string
  } else {
   throw DecodingError
    .dataCorrupted(.init(codingPath: container.codingPath,
               debugDescription: "Invalid int value"))
  }
 }
}
