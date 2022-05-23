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
    func getSearchFeed(cursor: String?, content: String, type: String?, orderBy: String) -> Observable<GetMainFeedResDTO> {
        let endpoint = FeedSearchEndpointCases.getSearchFeed(cursor: cursor, content: content, type: type, orderBy: orderBy)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> GetMainFeedResDTO  in
                print("~~~~>>\(http)")

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(GetMainFeedResDTO.self, from: resData)
                    print(result)
                    return result
                } catch {
                    print(error)
                }

                return GetMainFeedResDTO()
            }
    }

    func getSearchFeedHistory() -> Observable<[History]> {
        let endpoint = FeedSearchEndpointCases.getSearchFeedHistory
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> [History]  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode([History].self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return [History]()
            }
    }

    func deleteSearchFeedHistory(id: String) -> Observable<String> {
        let endpoint = FeedSearchEndpointCases.deleteSearchFeedHistory(id: id)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> String  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(String.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return String()
            }
    }

}
