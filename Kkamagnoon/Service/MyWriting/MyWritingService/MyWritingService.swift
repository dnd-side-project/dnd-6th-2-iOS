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
    var isMyWritingPaginating = false
    var isTempWritingPaginating = false

    func getMyArticle(cursor: String?, type: String?, pagination: Bool) -> Observable<ArticlesResponse> {
        if pagination {
            isMyWritingPaginating = true
        }

        let endpoint = MyWritingEndPointCases.getMyArticle(cursor: cursor, type: type)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> ArticlesResponse  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(ArticlesResponse.self, from: resData)

                        if pagination {
                            self.isMyWritingPaginating = false
                        }

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

    func postMyArticleFree(article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = MyWritingEndPointCases.postMyArticleFree(article: article)
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

    func postMyArticleTemp(article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = MyWritingEndPointCases.postMyArticleTemp(article: article)
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

    func getMyArticleTemp(cursor: String?, pagination: Bool) -> Observable<ArticlesResponse> {
        let endpoint = MyWritingEndPointCases.getMyArticleTemp(cursor: cursor)
        let request = makeRequest(endpoint: endpoint)

        if pagination {
            isTempWritingPaginating = true
        }

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> ArticlesResponse  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(ArticlesResponse.self, from: resData)

                        if pagination {
                            self.isTempWritingPaginating = false
                        }
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

    func getMyArticleDetail(articleId: String) -> Observable<MyWriting> {
        let endpoint = MyWritingEndPointCases.getMyArticleDetail(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> MyWriting  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(MyWriting.self, from: resData)
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

    func patchMyArticle(articleId: String, article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = MyWritingEndPointCases.patchMyArticle(articleId: articleId, article: article)
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

    func deleteMyArticle(articleIdArr: [String]) -> Observable<Int> {
        let endpoint = MyWritingEndPointCases.deleteMyArticle(articleIdArr: articleIdArr)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Int  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Int.self, from: resData)
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
