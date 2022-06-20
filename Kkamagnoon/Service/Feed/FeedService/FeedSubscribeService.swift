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
            .map { http, resData -> GetSubFeedResDTO  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(GetSubFeedResDTO.self, from: resData)
                        return result
                    } catch {
                        throw NetworkError.decodeError
                    }

                case 400:
                    throw NetworkError.wrongDataFormat

                case 401:
                    throw NetworkError.unauthorized

                case 403:
                    throw NetworkError.invalidRequest

                case 500:
                    throw NetworkError.serverError

                default:
                    throw NetworkError.emptyData
                }
            }
    }

    func getSubscribeAuthorList() -> Observable<[Host]> {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeAuthorList
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> [Host]  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode([Host].self, from: resData)
                        return result
                    } catch {
                        throw NetworkError.decodeError
                    }

                case 400:
                    throw NetworkError.wrongDataFormat

                case 401:
                    throw NetworkError.unauthorized

                case 403:
                    throw NetworkError.invalidRequest

                case 500:
                    throw NetworkError.serverError

                default:
                    throw NetworkError.emptyData
                }
            }
    }

    func getSubscribeFeedByAuthor(cursor: String?, authorId: String) -> Observable<GetSubFeedResDTO> {
        let endpoint = FeedSubscribeEndpointCases.getSubscribeFeedByAuthor(cursor: cursor, authorId: authorId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> GetSubFeedResDTO  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(GetSubFeedResDTO.self, from: resData)
                        return result
                    } catch {
                        throw NetworkError.decodeError
                    }

                case 400:
                    throw NetworkError.wrongDataFormat

                case 401:
                    throw NetworkError.unauthorized

                case 403:
                    throw NetworkError.invalidRequest

                case 500:
                    throw NetworkError.serverError

                default:
                    throw NetworkError.emptyData
                }
            }
    }

    func patchSubscribe(authorId: String) -> Observable<MessageResDTO> {
        let endpoint = FeedSubscribeEndpointCases.patchSubscribe(authorId: authorId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> MessageResDTO  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(MessageResDTO.self, from: resData)
                        return result
                    } catch {
                        throw NetworkError.decodeError
                    }

                case 400:
                    throw NetworkError.wrongDataFormat

                case 401:
                    throw NetworkError.unauthorized

                case 403:
                    throw NetworkError.invalidRequest

                case 500:
                    throw NetworkError.serverError

                default:
                    throw NetworkError.emptyData
                }
            }
    }

    func patchSubscribeCancel(authorId: String) -> Observable<MessageResDTO> {
        let endpoint = FeedSubscribeEndpointCases.patchSubscribeCancel(authorId: authorId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> MessageResDTO  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(MessageResDTO.self, from: resData)
                        return result
                    } catch {
                        throw NetworkError.decodeError
                    }

                case 400:
                    throw NetworkError.wrongDataFormat

                case 401:
                    throw NetworkError.unauthorized

                case 403:
                    throw NetworkError.invalidRequest

                case 500:
                    throw NetworkError.serverError

                default:
                    throw NetworkError.emptyData
                }
            }
    }
}
