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

    func postRelayRoom(relay: CreateRelayDTO) -> Observable<Relay> {
        let endpoint = RelayEndPointCases.postRelayRoom(relay: relay)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Relay  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Relay.self, from: resData)
                    print(result)
                    return result
                } catch {
                    print(error)
                }

                return Relay()
            }
    }

    func getRelayRoomParticitated(cursor: String?) -> Observable<RelayResponse> {
        let endpoint = RelayEndPointCases.getRelayRoomParticitated(cursor: cursor)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> RelayResponse  in
                print(">>>PARTICIPATED \(http)")
                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(RelayResponse.self, from: resData)
                    print(">>>PARTICIPATED \(result)")
                    return result
                } catch {
                    print(error)
                }

                return RelayResponse()
            }
    }

    func getRelayUserMade(cursor: String?) -> Observable<RelayResponse> {
        let endpoint = RelayEndPointCases.getRelayUserMade(cursor: cursor)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> RelayResponse  in
//                print(">>>MyRoom \(http)")

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(RelayResponse.self, from: resData)
//                    print(">>>MyRoom \(result)")
                    return result
                } catch {
                    print(error)
                }

                return RelayResponse()
            }
    }

    func patchRelayRoom(relayId: String, updateRelay: UpdateRelayDTO) -> Observable<Relay> {
            let endpoint = RelayEndPointCases.patchRelayRoom(relayId: relayId, updateRelay: updateRelay)

            let request = makeRequest(endpoint: endpoint)

            return RxAlamofire.request(request as URLRequestConvertible)
                .responseData()
                .asObservable()
                .map { _, resData -> Relay  in

                    let decoder = JSONDecoder()

                    do {
                        let result = try decoder.decode(Relay.self, from: resData)
                        return result
                    } catch {
                        print(error)
                    }

                    return Relay()
                }
    }

    func deleteRelayRoom(relayId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayEndPointCases.deleteRelayRoom(relayId: relayId)

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

    func getRelayRoomById(relayId: String) -> Observable<Relay> {
        let endpoint = RelayEndPointCases.getRelayRoomById(relayId: relayId)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { _, resData -> Relay  in

                let decoder = JSONDecoder()

                do {
                    let result = try decoder.decode(Relay.self, from: resData)
                    return result
                } catch {
                    print(error)
                }

                return Relay()
            }
    }

    func postRelayJoin(relayId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayEndPointCases.postRelayJoin(relayId: relayId)

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

    func deleteRelayJoin(relayId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayEndPointCases.deleteRelayJoin(relayId: relayId)

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
