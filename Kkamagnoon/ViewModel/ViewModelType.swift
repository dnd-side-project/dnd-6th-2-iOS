//
//  ViewModelType.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

protocol ViewModelType {
    associatedtype Input
    associatedtype Output

    var input: Input { get }
    var output: Output { get }
}
