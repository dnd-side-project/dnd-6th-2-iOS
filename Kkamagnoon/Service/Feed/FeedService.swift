////
////  FeedService.swift
////  Kkamagnoon
////
////  Created by 서정 on 2022/02/10.
////
//
// import RxSwift
// import SwiftyJSON
//
// import Alamofire
// import RxAlamofire
//
// class FeedService: FeedServiceType {
//
//    let BASE_URL = "http://15.164.99.32:3000/feed?page=1"
//    var service: String!
//    
//    let accessToken = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJlbWFpbCI6ImFiY2RAZ21haWwuY29tIiwiaWF0IjoxNjQ0NTU1ODMwLCJleHAiOjE2NDQ1NTk0MzB9.uyQHq-Q2-Kh8aRO4_s9PB_wn2XzBh-VE8NB7arLMIK4"
//
//    func getWholeFeed() -> Observable<[FeedInfo]> {
//        service = BASE_URL
//
////        let accessToken = TokenUtils.shared.read(account: .accessToken)
////
////        guard let accessToken = accessToken else {
////            return Observable.just([FeedInfo(id: "access token nil ERROR")])
////        }
//        
//
//        var request = URLRequest(url: URL(string: service)!)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        request.timeoutInterval = 10
//
//        return RxAlamofire.request(request as URLRequestConvertible)
//            .responseData()
//            .asObservable()
//            .map { _, str -> [FeedInfo] in
//
//                let json = JSON(str)
//                var wholeList: [FeedInfo] = []
//
//                for article in json.arrayValue {
//                    wholeList.append(FeedInfo(_id: article["_id"].stringValue,
//                                              scrapNum: article["scrapNum"].intValue,
//                                              commentNum: article["commentNum"].intValue,
//                                              likeNum: article["likeNum"].intValue,
//                                              public: article["public"].boolValue,
//                                              state: article["state"].boolValue,
//                                              keyWord: article["keyWord"].stringValue,
//                                              category: (article["category"].arrayObject as! [String]),
//                                              tags: (article["tags"].arrayObject as! [String]),
//                                              content: article["content"].stringValue,
//                                              title: article["title"].stringValue,
//                                              user: article["user"].stringValue,
//                                              createdAt: article["createdAt"].stringValue,
//                                              updatedAt: article["updatedAt"].stringValue,
//                                              __v: article["__v"].intValue)
//                                     )
//                }
//
//                return wholeList
//            }
//
//    }
//
//    func getSubscribeFeed() -> Observable<[FeedInfo]> {
//        service = BASE_URL.appending("/subscribe")
//
////        let accessToken = TokenUtils.shared.read(account: .accessToken)
////
////        guard let accessToken = accessToken else {
////            return Observable.just([FeedInfo(id: "access token nil ERROR")])
////        }
//        
//
//        var request = URLRequest(url: URL(string: service)!)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        request.timeoutInterval = 10
//
//        return RxAlamofire.request(request as URLRequestConvertible)
//            .responseData()
//            .asObservable()
//            .map { _, str -> [FeedInfo] in
//
//                let json = JSON(str)
//                var subscribeList: [FeedInfo] = []
//
//                for article in json.arrayValue {
//                    subscribeList.append(FeedInfo(_id: article["_id"].stringValue,
//                                              scrapNum: article["scrapNum"].intValue,
//                                              commentNum: article["commentNum"].intValue,
//                                              likeNum: article["likeNum"].intValue,
//                                              public: article["public"].boolValue,
//                                              state: article["state"].boolValue,
//                                              keyWord: article["keyWord"].stringValue,
//                                              category: (article["category"].arrayObject as! [String]),
//                                              tags: (article["tags"].arrayObject as! [String]),
//                                              content: article["content"].stringValue,
//                                              title: article["title"].stringValue,
//                                              user: article["user"].stringValue,
//                                              createdAt: article["createdAt"].stringValue,
//                                              updatedAt: article["updatedAt"].stringValue,
//                                              __v: article["__v"].intValue)
//                                     )
//                }
//
//                return subscribeList
//            }
//    }
//
//    func getSubscribeAuthorList() {
//        service = BASE_URL.appending("/subscribe/authorlist")
//        
//        //        let accessToken = TokenUtils.shared.read(account: .accessToken)
//        //
//        //        guard let accessToken = accessToken else {
//        //            return Observable.just([FeedInfo(id: "access token nil ERROR")])
//        //        }
//                
//
//        var request = URLRequest(url: URL(string: service)!)
//        request.httpMethod = "GET"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.setValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
//        request.timeoutInterval = 10
//
//        return RxAlamofire.request(request as URLRequestConvertible)
//            .responseData()
//            .asObservable()
//            .map { _, str -> [FeedInfo] in
//
//                let json = JSON(str)
//                var subscribeList: [FeedInfo] = []
//
//                for article in json.arrayValue {
//                    subscribeList.append(FeedInfo(_id: article["_id"].stringValue,
//                                              scrapNum: article["scrapNum"].intValue,
//                                              commentNum: article["commentNum"].intValue,
//                                              likeNum: article["likeNum"].intValue,
//                                              public: article["public"].boolValue,
//                                              state: article["state"].boolValue,
//                                              keyWord: article["keyWord"].stringValue,
//                                              category: (article["category"].arrayObject as! [String]),
//                                              tags: (article["tags"].arrayObject as! [String]),
//                                              content: article["content"].stringValue,
//                                              title: article["title"].stringValue,
//                                              user: article["user"].stringValue,
//                                              createdAt: article["createdAt"].stringValue,
//                                              updatedAt: article["updatedAt"].stringValue,
//                                              __v: article["__v"].intValue)
//                                     )
//                }
//
//                return subscribeList
//            }
//    }
//
//    func subscribeAuthorByArticle(articleId: Int) {
//        service = BASE_URL.appending("/subscribe/\(articleId)")
//    }
//
//    func getSearchFeed() {
//        service = BASE_URL.appending("/search")
//    }
//
//    func getArticle(articleId: Int) {
//        service = BASE_URL.appending("/\(articleId)")
//    }
//
//    func deleteArticle(articleId: Int) {
//        service = BASE_URL.appending("/\(articleId)")
//    }
//
//    func updateArticle(articleId: Int) {
//        service = BASE_URL.appending("/\(articleId)")
//    }
//
//    func writeCommentAtArticle(articleId: Int) {
//        service = BASE_URL.appending("/comment/\(articleId)")
//    }
//
//    func updateComment(commentId: Int) {
//        service = BASE_URL.appending("/comment/\(commentId)")
//    }
//
//    func deleteComment(commentId: Int) {
//        service = BASE_URL.appending("/\(commentId)")
//    }
//
//    func scrapArticle(articleId: Int) {
//        service = BASE_URL.appending("/scrap/\(articleId)")
//    }
//
//    func scrapCancel(articleId: Int) {
//        service = BASE_URL.appending("/scrap/\(articleId)")
//    }
//
//    func likeArticle(articleId: Int) {
//        service = BASE_URL.appending("/like/\(articleId)")
//    }
//
//    func likeCancel(articleId: Int) {
//        service = BASE_URL.appending("/like/\(articleId)")
//    }
// }
