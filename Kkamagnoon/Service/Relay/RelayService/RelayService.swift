//
//  RelayService.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/18.
//

import RxSwift

import RxAlamofire
import Alamofire

class RelayService: Service {

    func getRelayRoomList(cursor: String?, orderBy: String, tags: [String: Bool]?) -> Observable<RelayResponse> {
        let endpoint = RelayEndPointCases.getRelayRoomList(cursor: cursor, orderBy: orderBy, tags: tags)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> RelayResponse  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(RelayResponse.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return RelayResponse()
            }
    }

    func postRelayRoom(relay: CreateRelayDTO) {

    }

    func getRelayRoomParticitated(cursor: String?) -> Observable<RelayResponse> {
        let endpoint = RelayEndPointCases.getRelayRoomParticitated(cursor: cursor)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> RelayResponse  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(RelayResponse.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return RelayResponse()
            }
    }

    func patchRelayRoom(relayId: String, updateRelay: UpdateRelayDTO) {

    }
    func deleteRelayRoom(relayId: String) {

    }
    func postRelayJoin(relayId: String) {

    }
    func deleteRelayJoin(relayId: String) {

    }
}
