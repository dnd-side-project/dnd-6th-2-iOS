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
            .map { _, resData -> Notice  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Notice.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return Notice()
            }
    }

    func patchRelatNotice(relayId: String, noticeId: String, notice: String) -> Observable<AddNoticeDTO> {
        let endpoint = RelayNoticeEndPointCases.patchRelatNotice(relayId: relayId, noticeId: noticeId, notice: notice)
        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> AddNoticeDTO  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(AddNoticeDTO.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return AddNoticeDTO()
            }
    }

    func deleteRelayNotice(relayId: String, noticeId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayNoticeEndPointCases.deleteRelayNotice(relayId: relayId, noticeId: noticeId)

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
