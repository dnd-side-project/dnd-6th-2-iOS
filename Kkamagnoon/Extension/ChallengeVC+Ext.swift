//
//  ChallengeVC+Ext.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/03/08.
//
import UIKit
import FSCalendar
import RxGesture

extension ChallengeViewController {
    func setLayout() {

        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.left.right.top.equalTo(view.safeAreaLayoutGuide)
        }

        view.addSubview(scrollView)
        scrollView.snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom)
            $0.left.right.bottom.equalTo(view.safeAreaLayoutGuide)
        }

        scrollView.addSubview(challengeMainView)
        challengeMainView.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.edges.equalToSuperview()
        }

        view.addSubview(addWritingButton)
        addWritingButton.snp.makeConstraints {
            $0.size.equalTo(55.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalTo(view.safeAreaLayoutGuide).offset(-14.0)
        }

    }
}

extension ChallengeViewController {

    func bindInput() {
        headerView.bellButton.rx.tap
            .bind(to: viewModel.input.bellButtonTap)
            .disposed(by: disposeBag)

        addWritingButton.rx.tap
            .bind(to: viewModel.input.addWritingButtonTap)
            .disposed(by: disposeBag)

        challengeMainView.expansionButton.rx.tap
            .bind(to: viewModel.input.expansionButtonTap)
            .disposed(by: disposeBag)

        challengeMainView.todayKeyWordView.goToFeedButton
            .rx.tap
            .bind(to: viewModel.input.goToFeedButtonTap)
            .disposed(by: disposeBag)

        challengeMainView.selectMonthButton.rx.tap
            .bind(to: viewModel.input.selectMonthButtonTap)
            .disposed(by: disposeBag)

        challengeMainView.dropdown.selectionAction = { [weak self] (_, item) in
            guard let self = self else { return }
            self.viewModel.output.month.accept(self.convertMMMString(month: item))
        }
    }

    func bindOutput() {
        viewModel.output.showError
            .asSignal()
            .emit(onNext: showError)
            .disposed(by: disposeBag)

        viewModel.output.goToBellNotice
            .asSignal()
            .emit(onNext: goToBellNoticeVC)
            .disposed(by: disposeBag)

        viewModel.output.goToWriting
            .asSignal()
            .emit(onNext: goToWritingVC)
            .disposed(by: disposeBag)

//        viewModel.output.goToDetail
//            .asSignal()
//            .emit(onNext: goToDetail)
//            .disposed(by: disposeBag)

        viewModel.output.calendarState
            .skip(1)
            .asDriver(onErrorJustReturn: .week)
            .drive(onNext: setCalendarState)
            .disposed(by: disposeBag)

        viewModel.output.challenge
            .bind(onNext: setChallengeMainData)
            .disposed(by: disposeBag)

        viewModel.output.challangeStamp
            .bind(onNext: setStampData)
            .disposed(by: disposeBag)

        viewModel.output.goToFeed
            .asSignal()
            .emit(onNext: goToFeed)
            .disposed(by: disposeBag)

        viewModel.output.month
            .asDriver()
            .drive(onNext: setMonthDropdownText)
            .disposed(by: disposeBag)

        viewModel.output.openDropdown
            .asSignal()
            .emit(onNext: openDropdown)
            .disposed(by: disposeBag)
    }
}

extension ChallengeViewController {

    private func goToBellNoticeVC() {
        let vc = BellNoticeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setImageCaseNothing() {
        challengeMainView.subTitleLabel[1].isHidden = true
        scrollView.addSubview(nothingImageView)
        nothingImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(challengeMainView.todayKeyWordView.snp.bottom).offset(30.51)
            $0.width.equalTo(122)
            $0.height.equalTo(110)
        }

        scrollView.addSubview(nothingLabel)
        nothingLabel.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalTo(nothingImageView.snp.bottom).offset(9)
            $0.bottom.equalToSuperview().offset(-30.0)
        }
    }

    private func removeImageCaseNothing() {
        challengeMainView.subTitleLabel[1].isHidden = false
        nothingImageView.removeFromSuperview()
        nothingLabel.removeFromSuperview()
    }

    private func goToWritingVC() {
        let vc = WritingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true
        vc.viewModel.rootView = self

        self.navigationController?.pushViewController(vc, animated: true)
    }

    func setCalendarState(_ state: CalendarState) {
        if state == .week {
            challengeMainView.calendarView.setScope(.week, animated: true)
            UIView.animate(withDuration: 10.0, delay: 0) {
                self.challengeMainView.calendarView.snp.updateConstraints {
                    $0.height.equalTo(144.0)
                }
            }
//            self.challengeMainView.layoutIfNeeded()
        } else {
            challengeMainView.calendarView.setScope(.month, animated: true)
            UIView.animate(withDuration: 10.0, delay: 0) {
                self.challengeMainView.calendarView.snp.updateConstraints {
                    $0.height.equalTo(400.0)
                }
            }
//            self.challengeMainView.layoutIfNeeded()
        }
    }

    private func goToDetail() {
        let vc = DetailContentViewController()
        vc.modalPresentationStyle = .fullScreen

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToFeed() {
        let vc = FeedViewController()
        vc.modalPresentationStyle = .fullScreen
        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func convertMonthString(monthMMM: String) -> String {
        switch monthMMM {
        case "Jan":
            return "1월"
        case "Feb":
            return "2월"
        case "Mar":
            return "3월"
        case "Apr":
            return "4월"
        case "May":
            return "5월"
        case "Jun":
            return "6월"
        case "Jul":
            return "7월"
        case "Aug":
            return "8월"
        case "Sep":
            return "9월"
        case "Oct":
            return "10월"
        case "Nov":
            return "11월"
        case "Dec":
            return "12월"
        default:
            return ""
        }
    }

    private func convertMMMString(month: String) -> String {
        switch month {
        case "1월":
            return "Jan"
        case "2월":
            return "Feb"
        case "3월":
            return "Mar"
        case "4월":
            return "Apr"
        case "5월":
            return "May"
        case "6월":
            return "Jun"
        case "7월":
            return "Jul"
        case "8월":
            return "Aug"
        case "9월":
            return "Sep"
        case "10월":
            return "Oct"
        case "11월":
            return "Nov"
        case "12월":
            return "Dec"
        default:
            return ""
        }
    }

    private func setMonthDropdownText(month: String) {
        let monthString = convertMonthString(monthMMM: month)
        challengeMainView.selectMonthButton.setTitle(monthString, for: .normal)
    }

    private func openDropdown() {
        challengeMainView.dropdown.show()
    }
}

extension ChallengeViewController: FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar,
                  boundingRectWillChange bounds: CGRect,
                  animated: Bool) {
        print(bounds.height)
        self.challengeMainView.calendarView.snp.updateConstraints { (make) in
            make.height.equalTo(bounds.height)
        }
        self.view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        if self.eventsArray.contains(date) {
            return 1
        }
        view.layoutIfNeeded()

        if self.eventsArray_Done.contains(date) {
            return 1
        }

        return 0
    }

    private func setChallengeMainData(_ challenge: GetChallengeMain) {
        setKeyword(keyword: challenge.keyword?.content ?? "NaN")

        setChallengeArticle(articles: challenge.articles ?? [])
    }

    private func setStampData(challengeStamp: GetMonthlyDTO) {
        challengeMainView.subTitleLabel[0].text = "이번달은 \(challengeStamp.monthlyStamp ?? 0)개의 스탬프를 찍었어요!"
        setStamp(history: challengeStamp.monthlyChallengeHistory ?? [])
    }

    private func setKeyword(keyword: String) {
        challengeMainView.todayKeyWordView
            .keywordLabel.text = keyword
    }

    private func setStamp(history: [String]) {
        history.forEach({ date in
            print(date)
            if let date = self.formatter.date(from: date) {
                self.eventsArray.append(date)
            }
        })

    }

    private func setChallengeArticle(articles: [Article]) {

        if articles.count == 0 {
            setImageCaseNothing()
        } else {
            removeImageCaseNothing()
            challengeMainView.removeCard()

            articles.forEach({ article in
                let card = MyChallengeCard()
                card.titleLabel.text = article.title
                card.contentLabel.text = article.content
                card.likeLabel.labelView.text = "\(article.likeNum ?? 0)"
                card.commentLabel.labelView.text = "\(article.commentNum ?? 0)"

                card.rx.tapGesture()
                    .when(.recognized)
                    .withUnretained(self)
                    .subscribe(onNext: { owner, _ in
                        owner.goToDetailPage(article: article)
                    })
                    .disposed(by: disposeBag)

                self.challengeMainView.stackView.addArrangedSubview(card)
            })
        }
    }

    private func goToDetailPage(article: Article) {
        let vc = DetailMyWritingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        vc.detailViewModel.input.articleId.accept(article._id ?? "")
        self.navigationController?.pushViewController(vc, animated: true)
    }

}

// extension ChallengeViewController: FSCalendarDelegate {
//
//    // 날짜 선택 시 콜백 메소드
//    func calendar(_ calendar: FSCalendar,
//                  didSelect date: Date,
//                  at monthPosition: FSCalendarMonthPosition) {
//
//        print(formatter.string(from: date) + " 선택됨")
//    }
//    // 날짜 선택 해제 시 콜백 메소드
//    public func calendar(_ calendar: FSCalendar,
//                         didDeselect date: Date,
//                         at monthPosition: FSCalendarMonthPosition) {
//        eventsArray = []
//        print(formatter.string(from: date) + " 해제됨")
//
//    }
//
// }

extension ChallengeViewController: FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {

        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarDateCell.identifier, for: date, at: position)

        return cell
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .clear
    }

}
