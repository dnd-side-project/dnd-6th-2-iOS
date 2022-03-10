//
//  FeedSearchService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//
import RxSwift
import Alamofire
import RxAlamofire

class FeedSearchService: Service {
    func getSearchFeed(cursor: String?, content: String, option: String, type: String?, orderBy: String) -> Observable<GetMainFeedResDTO> {
        let endpoint = FeedSearchEndpointCases.getSearchFeed(cursor: cursor, content: content, option: option, type: type, orderBy: orderBy)
        let request = makeRequest(endpoint: endpoint)
        
        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> GetMainFeedResDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(GetMainFeedResDTO.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return GetMainFeedResDTO()
            }
    }

    func getSearchFeedHistory() {
        let endpoint = FeedSearchEndpointCases.getSearchFeedHistory
        let request = makeRequest(endpoint: endpoint)
    }

    func deleteSearchFeedHistory(id: String) {
        let endpoint = FeedSearchEndpointCases.deleteSearchFeedHistory(id: id)
        let request = makeRequest(endpoint: endpoint)
    }

}
