//
//  FeedCommentService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/17.
//

import RxSwift
import Alamofire
import RxAlamofire

class FeedCommentService: Service {
    func getComment(articleId: String) -> Observable<[Comment]> {
        let endpoint = FeedCommentEndpointCases.getComment(articleId: articleId)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> [Comment] in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode([Comment].self, from: resData)
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

    func postComment(articleId: String, content: String) -> Observable<Comment> {
        let endpoint = FeedCommentEndpointCases.postComment(articleId: articleId, content: content)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Comment  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Comment.self, from: resData)
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

    func patchComment(articleId: String, commentId: String, content: String) -> Observable<Comment> {
        let endpoint = FeedCommentEndpointCases.patchComment(articleId: articleId, commentId: commentId, content: content)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Comment  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Comment.self, from: resData)
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

    func deleteComment(articleId: String, commentId: String) -> Observable<MessageResDTO> {
        let endpoint = FeedCommentEndpointCases.deleteComment(articleId: articleId, commentId: commentId)
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
