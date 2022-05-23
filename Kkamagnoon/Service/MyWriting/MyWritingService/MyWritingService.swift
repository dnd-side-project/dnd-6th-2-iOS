//
//  MyWritingService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/24.
//

import RxSwift
import RxAlamofire
import Alamofire

class MyWritingService: Service {
    var isPaginating = false

    func getMyArticle(cursor: String?, type: String?, pagination: Bool) -> Observable<ArticlesResponse> {
        if pagination {
            isPaginating = true
        }

        let endpoint = MyWritingEndPointCases.getMyArticle(cursor: cursor, type: type)
        let request = makeRequest(endpoint: endpoint)

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

                if pagination {
                    self.isPaginating = false
                }

                return ArticlesResponse()
            }
    }

    func postMyArticleFree(article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = MyWritingEndPointCases.postMyArticleFree(article: article)
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

    func postMyArticleTemp(article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = MyWritingEndPointCases.postMyArticleTemp(article: article)
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

    func getMyArticleTemp(cursor: String?) -> Observable<ArticlesResponse> {
        let endpoint = MyWritingEndPointCases.getMyArticleTemp(cursor: cursor)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> ArticlesResponse  in
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(ArticlesResponse.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return ArticlesResponse()
            }
    }

    func getMyArticleDetail(articleId: String) -> Observable<MyWriting> {
        let endpoint = MyWritingEndPointCases.getMyArticleDetail(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> MyWriting  in
                let decoder = JSONDecoder()
                print(http)

                do {
                    let result = try decoder.decode(MyWriting.self, from: resData)
                    print(result)
                    return result
                } catch {
                    print(error)
                }

                return MyWriting()
            }
    }

    func patchMyArticle(articleId: String, article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = MyWritingEndPointCases.patchMyArticle(articleId: articleId, article: article)
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

    func deleteMyArticle(articleIdArr: [String]) -> Observable<Int> {
        let endpoint = MyWritingEndPointCases.deleteMyArticle(articleIdArr: articleIdArr)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Int  in
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Int.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return 0
            }
    }

}
