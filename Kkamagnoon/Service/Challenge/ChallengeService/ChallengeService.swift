//
//  ChallengeService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import RxSwift
import RxAlamofire
import Alamofire

class ChallengeService: Service {
    func getChallenge() -> Observable<GetChallengeMain> {
        let endpoint = ChallengeEndPointCases.getChallenge
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> GetChallengeMain  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(GetChallengeMain.self, from: resData)
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

    func getChallengeStamp(month: String, year: String) -> Observable<GetMonthlyDTO> {
        let endpoint = ChallengeEndPointCases.getChallengeStamp(month: month, year: year)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> GetMonthlyDTO  in
                print(http)

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(GetMonthlyDTO.self, from: resData)
                    print("RES>>>>>\(result)")
                    return result
                } catch {
                    print(error)
                }

                return GetMonthlyDTO()
            }
    }

    func getChallengeArticle() -> Observable<Tip> {
        let endpoint = ChallengeEndPointCases.getChallengeArticle
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Tip  in
//                print(http)

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Tip.self, from: resData)
//                    print("RES>>>>>\(result)")
                    return result
                } catch {
                    print(error)
                }

                return Tip()
            }
    }

    func postChallengeArticle(article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = ChallengeEndPointCases.postChallengeArticle(article: article)
        let request = makeRequest(endpoint: endpoint)

        print("RES Challenge ARTICLE>>>>> \(article)")

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Article  in
                print("RES Challenge>>>>>\(http)")

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Article.self, from: resData)
                    print("RES Challenge>>>>>\(result)")
                    return result
                } catch {
                    print(error)
                }

                return Article()
            }
    }

    func postChallengeArticleTemp(article: CreateArticleDTO) -> Observable<Article> {
        let endpoint = ChallengeEndPointCases.postChallengeArticleTemp(article: article)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Article  in
//                print(http)

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Article.self, from: resData)
//                    print("RES>>>>>\(result)")
                    return result
                } catch {
                    print(error)
                }

                return Article()
            }
    }

    // 개발용
    func getChallengeKeyword() {

    }

    func postChallengeKeyword(content: String) {

    }

}
