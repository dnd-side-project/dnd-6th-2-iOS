//
//  TokenUtils.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/11.
//

import Foundation
import Alamofire

enum TokenType {
    case accessToken
    case refreshToken
}

class TokenUtils {
    static let shared = TokenUtils()

    func create(account: TokenType, value: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account,
            kSecValueData: value.data(using: .utf8, allowLossyConversion: false)!
        ]

        SecItemDelete(keyChainQuery)

        let status: OSStatus = SecItemAdd(keyChainQuery, nil)
        assert(status == noErr, "failed to saving Token")
    }

//    func read(account: TokenType) -> String? {
//        let keyChainQuery: NSDictionary = [
//            kSecClass: kSecClassGenericPassword,
//            kSecAttrAccount: account,
//            kSecReturnData: kCFBooleanTrue!,
//            kSecMatchLimit: kSecMatchLimitOne
//        ]
//
//        var dataTypeRef: AnyObject?
//        let status = SecItemCopyMatching(keyChainQuery, &dataTypeRef)
//
//        if status == errSecSuccess {
//            let retrivedData = dataTypeRef as! Data
//            let value = String(data: retrivedData, encoding: String.Encoding.utf8)
//            return value
//        } else {
//            print("failed to loading, status code = \(status)")
//            return nil
//        }
//    }

    // TEMP
    func read(account: TokenType) -> String? {

        return "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImhvdHRpbmdnb3RAbmF2ZXIuY29tIiwiaWF0IjoxNjU1NzkwNjgwLCJleHAiOjE2NTU4MDE0ODB9.aWN347b6FnPcwQChTqdEdJFmfH_8s8GR_V60SCaCKVM"
    }

    func delete(account: String) {
        let keyChainQuery: NSDictionary = [
            kSecClass: kSecClassGenericPassword,
            kSecAttrAccount: account
        ]

        let status = SecItemDelete(keyChainQuery)
        assert(status == noErr, "failed to delete the value, status code = \(status)")
    }
}
