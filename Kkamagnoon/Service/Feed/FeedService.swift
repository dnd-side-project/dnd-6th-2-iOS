//
//  FeedService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

 import RxSwift
 import SwiftyJSON

 import Alamofire
 import RxAlamofire

class FeedService {

    var bag = DisposeBag()

    func getWholeFeed(page: Int) {
        let endpoint = FeedEndpointCases.getWholeFeed(page: page)

        let url = URL(string: endpoint.url)!
        var request = URLRequest(url: url)

        request.httpMethod = endpoint.httpMethod
        endpoint.headers?.forEach({ header in
            request.setValue(header.value as? String, forHTTPHeaderField: header.key)
        })

        RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
        // temp (bind -> map)
            .bind { _, resData  in
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(FeedInfo.self, from: resData)
                    print(result)
                } catch {
                    print(error)
                }

            }
            .disposed(by: bag)
    }
}
