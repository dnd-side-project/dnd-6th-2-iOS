//
//  Service.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import Foundation

class Service {
    func makeRequest(endpoint: EndPoint) -> URLRequest {

        let url = URL(string: endpoint.url)!
        
        var request = URLRequest(url: url)
        request.httpMethod = endpoint.httpMethod
        endpoint.headers?.forEach({ header in
            request.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })
        
        return request
    }
}
