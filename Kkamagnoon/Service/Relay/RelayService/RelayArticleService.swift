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
            .map { _, resData -> GetRelayArticleResDTO  in
                print("RELAYArticle >>> \(request)")
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(GetRelayArticleResDTO.self, from: resData)

                    print("RELAYArticle >>> \(result)")
                    return result
                } catch {
                    print(error)
                }

                return GetRelayArticleResDTO()
            }
    }

    func postRelayArticle(relayId: String, content: String) -> Observable<Article> {
        let endpoint = RelayArticleEndPointCases.postRelayArticle(relayId: relayId, content: content)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Article  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Article.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return Article()
            }
    }

    func patchRelatArticle(relayId: String, articleId: String, content: String) -> Observable<RelayArticleDTO> {
        let endpoint = RelayArticleEndPointCases.patchRelatArticle(relayId: relayId, articleId: articleId, content: content)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> RelayArticleDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(RelayArticleDTO.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return RelayArticleDTO()
            }
    }

    func deleteRelayArticle(relayId: String, articleId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayArticleEndPointCases.deleteRelayArticle(relayId: relayId, articleId: articleId)

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
