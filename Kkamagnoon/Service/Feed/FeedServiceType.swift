//
//  FeedServiceType.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/10.
//

import RxSwift

protocol FeedServiceType {

    // 전체 피드 조회
    func getWholeFeed() -> Observable<[FeedInfo]>

    // 구독 피드 조회
    func getSubscribeFeed() -> Observable<[FeedInfo]>

    // 구독 작가들 전체 목록 조회
    func getSubscribeAuthorList()

    // 작가 구독하기 : PATCH
    func subscribeAuthorByArticle(articleId: Int)

    // 피드 검색하기
    func getSearchFeed()

    // 피드 글 상세 조회
    func getArticle(articleId: Int)

    // 피드 글 삭제 : DELETE
    func deleteArticle(articleId: Int)

    // 피드 글 수정 : PATCH
    func updateArticle(articleId: Int)

    // 댓글 작성 : POST
    func writeCommentAtArticle(articleId: Int)

    // 댓글 수정 : PATCH
    func updateComment(commentId: Int)

    // 댓글 삭제 : DELETE
    func deleteComment(commentId: Int)

    // 스크랩 : POST
    func scrapArticle(articleId: Int)

    // 스크랩 취소 : DELETE
    func scrapCancel(articleId: Int)

    // 좋아요 : POST
    func likeArticle(articleId: Int)

    // 좋아요 취소 : DELETE
    func likeCancel(articleId: Int)
}
