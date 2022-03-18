//
//  FeedSubscribeService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//
import RxSwift
import Alamofire
import RxAlamofire

class FeedSubscribeService: Service {
    func getSubscribeFeed(cursor: String?) -> Observable<GetSubFeedResDTO> {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeFeed(cursor: cursor)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> GetSubFeedResDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(GetSubFeedResDTO.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return GetSubFeedResDTO()
            }
    }

    func getSubscribeAuthorList() -> Observable<[Host]> {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeAuthorList
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> [Host]  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode([Host].self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return [Host]()
            }
    }

    func getSubscribeFeedByAuthor(cursor: String?, authorId: String) -> Observable<GetSubFeedResDTO> {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeFeedByAuthor(cursor: cursor, authorId: authorId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> GetSubFeedResDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(GetSubFeedResDTO.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return GetSubFeedResDTO()
            }
    }

    func patchSubscribe(authorId: String) -> Observable<MessageResDTO> {
        let endpoint = FeedSubscribeEndpointCases.patchSubscribe(authorId: authorId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> MessageResDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(MessageResDTO.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return MessageResDTO()
            }
    }

    func patchSubscribeCancel(authorId: String) -> Observable<MessageResDTO> {
        let endpoint = FeedSubscribeEndpointCases.patchSubscribeCancel(authorId: authorId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> MessageResDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(MessageResDTO.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return MessageResDTO()
            }
    }
}
