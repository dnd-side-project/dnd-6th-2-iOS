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

class FeedService: Service {

    // TEMP
    var bag = DisposeBag()

    func getWholeFeed(next_cursor: String?, orderBy: String = "최신순", tags: [String: Bool]?) -> Observable<ArticlesResponse> {
        let endpoint = FeedEndpointCases.getWholeFeed(cursor: next_cursor, orderBy: orderBy, tags: tags)

        let request = makeRequest(endpoint: endpoint)

        // DEBUG

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> ArticlesResponse  in

                print(http)
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(ArticlesResponse.self, from: resData)
                    print("RES>>>>>\(result)")
                    return result
                } catch {
                    print(error)
                }

                return ArticlesResponse()
            }
    }

    func getArticle(articleId: String) {
        let endpoint = FeedEndpointCases.getArticle(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)
    }

    func deleteArticle(articleId: String) {
        let endpoint = FeedEndpointCases.deleteArticle(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)
    }

    func patchArticle(articleId: String, articleInfo: CreateArticleDTO) {
        let endpoint = FeedEndpointCases.patchArticle(articleId: articleId, articleInfo: articleInfo)
        let request = makeRequest(endpoint: endpoint)
    }

    func postScrap(articleId: String, scrap: ScrapDTO) -> Observable<ScrapResponse> {
        let endpoint = FeedEndpointCases.postScrap(articleId: articleId, scrap: scrap)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> ScrapResponse  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(ScrapResponse.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return ScrapResponse()
            }

    }

    func deleteScrap(articleId: String) {
        let endpoint = FeedEndpointCases.deleteScrap(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)
    }

    func postLike(articleId: String, like: ScrapDTO) -> Observable<LikeResponse> {
        let endpoint = FeedEndpointCases.postLike(articleId: articleId, like: like)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> LikeResponse  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(LikeResponse.self, from: resData)
                    return result
                } catch {
                    print(error)
                }
                return LikeResponse()
            }
    }

    func deleteLike(articleId: String) {
        let endpoint = FeedEndpointCases.deleteLike(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)
    }

}
