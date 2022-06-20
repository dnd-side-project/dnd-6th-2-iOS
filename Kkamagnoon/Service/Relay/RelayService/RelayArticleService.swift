//
//  RelayArticleService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import RxSwift
import RxAlamofire
import Alamofire

class RelayArticleService: Service {
    func getRelayArticle(relayId: String, cursor: String?) -> Observable<GetRelayArticleResDTO> {
        let endpoint = RelayArticleEndPointCases.getRelayArticle(relayId: relayId, cursor: cursor)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> GetRelayArticleResDTO  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(GetRelayArticleResDTO.self, from: resData)
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

    func postRelayArticle(relayId: String, relayArticle: RelayArticleDTO) -> Observable<Article> {
        let endpoint = RelayArticleEndPointCases.postRelayArticle(relayId: relayId, relayArticle: relayArticle)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Article  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Article.self, from: resData)
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

    func patchRelatArticle(relayId: String, articleId: String, content: String) -> Observable<RelayArticleDTO> {
        let endpoint = RelayArticleEndPointCases.patchRelatArticle(relayId: relayId, articleId: articleId, content: content)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> RelayArticleDTO  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(RelayArticleDTO.self, from: resData)
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

    func deleteRelayArticle(relayId: String, articleId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayArticleEndPointCases.deleteRelayArticle(relayId: relayId, articleId: articleId)

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
