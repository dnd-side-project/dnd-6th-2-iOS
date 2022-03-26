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
                print(">>>Comment: \(http)")
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode([Comment].self, from: resData)
                    print(">>>Comment: \(result)")
                    return result
                } catch {
                    print(error)
                }

                return [Comment]()
            }
    }

    func postComment(articleId: String, content: String) -> Observable<Comment> {
        let endpoint = FeedCommentEndpointCases.postComment(articleId: articleId, content: content)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Comment  in

                let decoder = JSONDecoder()
                print(">>>sendComment : \(http)")

                do {
                    let result = try decoder.decode(Comment.self, from: resData)
                    print(">>>sendComment : \(result)")
                    return result
                } catch {
                    print(error)
                }

                return Comment()
            }
    }

    func patchComment(articleId: String, commentId: String, content: String) -> Observable<Comment> {
        let endpoint = FeedCommentEndpointCases.patchComment(articleId: articleId, commentId: commentId, content: content)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Comment  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Comment.self, from: resData)

                    return result
                } catch {
                    print(error)
                }

                return Comment()
            }
    }

    func deleteComment(articleId: String, commentId: String) -> Observable<MessageResDTO> {
        let endpoint = FeedCommentEndpointCases.deleteComment(articleId: articleId, commentId: commentId)
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
