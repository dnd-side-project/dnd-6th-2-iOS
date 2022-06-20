//
//  RelayNoticeService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import RxSwift
import RxAlamofire
import Alamofire

class RelayNoticeService: Service {
    func postRelayNotice(relayId: String, notice: String) -> Observable<Notice> {
        let endpoint = RelayNoticeEndPointCases.postRelayNotice(relayId: relayId, notice: notice)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Notice  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Notice.self, from: resData)
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

    func patchRelatNotice(relayId: String, noticeId: String, notice: String) -> Observable<AddNoticeDTO> {
        let endpoint = RelayNoticeEndPointCases.patchRelatNotice(relayId: relayId, noticeId: noticeId, notice: notice)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> AddNoticeDTO  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(AddNoticeDTO.self, from: resData)
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

    func deleteRelayNotice(relayId: String, noticeId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayNoticeEndPointCases.deleteRelayNotice(relayId: relayId, noticeId: noticeId)

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
