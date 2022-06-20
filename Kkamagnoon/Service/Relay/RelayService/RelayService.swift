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
            .map { http, resData -> RelayResponse  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(RelayResponse.self, from: resData)
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

    func postRelayRoom(relay: CreateRelayDTO) -> Observable<Relay> {
        let endpoint = RelayEndPointCases.postRelayRoom(relay: relay)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Relay  in

                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Relay.self, from: resData)
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

    func getRelayRoomParticitated(cursor: String?) -> Observable<RelayResponse> {
        let endpoint = RelayEndPointCases.getRelayRoomParticitated(cursor: cursor)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> RelayResponse  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(RelayResponse.self, from: resData)
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

    func getRelayUserMade(cursor: String?) -> Observable<RelayResponse> {
        let endpoint = RelayEndPointCases.getRelayUserMade(cursor: cursor)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> RelayResponse  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(RelayResponse.self, from: resData)
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

    func patchRelayRoom(relayId: String, updateRelay: UpdateRelayDTO) -> Observable<Relay> {
            let endpoint = RelayEndPointCases.patchRelayRoom(relayId: relayId, updateRelay: updateRelay)

            let request = makeRequest(endpoint: endpoint)

            return RxAlamofire.request(request as URLRequestConvertible)
                .responseData()
                .asObservable()
                .map { http, resData -> Relay  in
                    switch http.statusCode {
                    case 200 ..< 300 :
                        do {
                            let result = try self.decoder.decode(Relay.self, from: resData)
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

    func deleteRelayRoom(relayId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayEndPointCases.deleteRelayRoom(relayId: relayId)

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

    func getRelayRoomById(relayId: String) -> Observable<Relay> {
        let endpoint = RelayEndPointCases.getRelayRoomById(relayId: relayId)

        let request = makeRequest(endpoint: endpoint)

        return RxAlamofire.request(request as URLRequestConvertible)
            .responseData()
            .asObservable()
            .map { http, resData -> Relay  in
                switch http.statusCode {
                case 200 ..< 300 :
                    do {
                        let result = try self.decoder.decode(Relay.self, from: resData)
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

    func postRelayJoin(relayId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayEndPointCases.postRelayJoin(relayId: relayId)

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

    func deleteRelayJoin(relayId: String) -> Observable<MessageResDTO> {
        let endpoint = RelayEndPointCases.deleteRelayJoin(relayId: relayId)

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
