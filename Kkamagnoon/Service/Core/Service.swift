//
//  Service.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//
import Foundation

class Service {

    let decoder = JSONDecoder()

    func makeRequest(endpoint: EndPoint) -> URLRequest {

        let url = URL(string: endpoint.url)!
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        endpoint.headers?.forEach({ header in
            request.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        if let body = endpoint.body {
            if !body.isEmpty {
                request.httpBody = try? JSONSerialization.data(withJSONObject: body)
            }
        }

        return request
    }
    
}
