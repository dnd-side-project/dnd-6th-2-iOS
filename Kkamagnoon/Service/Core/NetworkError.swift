//
//  NetworkError.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/12.
//

import Foundation

enum NetworkError: LocalizedError {
    case unknownError
    case invalidHttpStatusCode(Int)
    case components
    case urlRequest(Error)
    case parsing(Error)
    case emptyData
    case decodeError

    /// 400
///    POST, PATCH 요청 시 body 정보 포함되지 않은 경우
///    필수 정보 누락되어 요청된 경우
///    잘못된 형식의 요청인 경우 → ex.) string 정보를 number type으로 보낸 경우
    case wrongDataFormat

    /// 401
    /// 로그인이 되어있지 않은 경우 (로그인이 필수적인 기능에 한해)
    case unauthorized

    /// 403
    /// 접근이 허용되지 않은 경우
    /// ex.) 내가 작성한 글이 아닌 다른 유저의 글을 수정, 삭제 요청한 경우 등
    case invalidRequest

    /// 404
    /// 요청한 정보를 데이터베이스에 찾을 수 없는 경우
    case cannotFindData

    /// 500
    /// 서버 에러
    case serverError

    var errorDescription: String {
        switch self {
        case .unknownError:
            return "알수 없는 에러입니다."
        case .invalidHttpStatusCode:
            return "status코드가 200~299가 아닙니다."
        case .components:
            return "components를 생성 에러가 발생했습니다."
        case .urlRequest:
            return "URL request 관련 에러가 발생했습니다."
        case .parsing:
            return "데이터 parsing 중에 에러가 발생했습니다."
        case .emptyData:
            return "data가 비어있습니다."
        case .decodeError:
            return "decode 에러가 발생했습니다."

            ////////////
        case .wrongDataFormat:
            return "잘못된 형식의 데이터입니다."
        case .unauthorized:
            return "로그인 유효기간이 만료되었습니다."
        case .invalidRequest:
            return "잘못된 요청입니다."
        case .cannotFindData:
            return "데이터를 찾을 수 없습니다."
        case .serverError:
            return "서버 에러입니다."
        }
    }
}
