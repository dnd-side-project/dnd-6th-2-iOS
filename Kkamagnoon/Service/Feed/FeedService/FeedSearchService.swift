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
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(GetMainFeedResDTO.self, from: resData)
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

    func getSearchFeedHistory() -> Observable<[History]> {
        let endpoint = FeedSearchEndpointCases.getSearchFeedHistory
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> [History]  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode([History].self, from: resData)
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

    func deleteSearchFeedHistory(id: String) -> Observable<String> {
        let endpoint = FeedSearchEndpointCases.deleteSearchFeedHistory(id: id)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> String  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(String.self, from: resData)
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
