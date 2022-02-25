//
//  ChallengeViewController.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/06.
//
import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa
import FSCalendar

class ChallengeViewController: UIViewController {

    let viewModel = ChallengeViewModel()
    var disposeBag = DisposeBag()

    let formatter = DateFormatter()
    var eventsArray = [Date]()
    var eventsArray_Done = [Date]()

    var isMonth: Bool = false

    var scrollView = UIScrollView()
        .then {
            $0.showsVerticalScrollIndicator = false
        }

    var challengeMainView = ChallengeMainView()

    var addWritingButton = MakingRoomButton()
        .then {
            $0.setImage(UIImage(named: "Pencil"), for: .normal)
        }

    var headerView = ChallengeHeaderView()

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addWritingButton.layer.cornerRadius = addWritingButton.frame.size.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        challengeMainView.calendarView.delegate = self
        challengeMainView.calendarView.dataSource = self

        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"

        let xmas = formatter.date(from: "2022-2-21")
        let sampledate = formatter.date(from: "2022-3-30")
        eventsArray = [xmas!, sampledate!]

        setView()

        bindView()

        viewModel.bindKeyword()
    }

    func setView() {

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

    func bindView() {
        // Input
        headerView.bellButton.rx.tap
            .bind(to: viewModel.input.bellButtonTap)
            .disposed(by: disposeBag)

        addWritingButton.rx.tap
            .bind(to: viewModel.input.addWritingButtonTap)
            .disposed(by: disposeBag)

        challengeMainView.expansionButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                owner.setCalendarState()
            }
            .disposed(by: disposeBag)

        // Output
        viewModel.output.goToBellNotice
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToBellNoticeVC()
            }
            .disposed(by: disposeBag)

        viewModel.output.goToWriting
            .withUnretained(self)
            .bind { owner, _ in
                owner.goToWritingVC()
            }
            .disposed(by: disposeBag)

        viewModel.output.keyWord
            .withUnretained(self)
            .bind { owner, keyword in
                owner.challengeMainView.todayKeyWordView
                    .keywordLabel.text = keyword.content
            }
            .disposed(by: disposeBag)
    }

    private func goToBellNoticeVC() {
        let vc = BellNoticeViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func goToWritingVC() {
        let vc = WritingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

    private func setCalendarState() {
        if isMonth {
            isMonth = false
            challengeMainView.calendarView.setScope(.week, animated: true)
            UIView.animate(withDuration: 10.0, delay: 0) {
                self.challengeMainView.calendarHeight.constant = 144
            }
        } else {
            isMonth = true
            challengeMainView.calendarView.setScope(.month, animated: true)
            UIView.animate(withDuration: 10.0, delay: 0) {
                self.challengeMainView.calendarHeight.constant = 400

            }

        }
    }

}

extension ChallengeViewController: FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar,
                  boundingRectWillChange bounds: CGRect,
                  animated: Bool) {

        challengeMainView.calendarHeight.constant = 144

        self.view.layoutIfNeeded()
    }

    func calendar(_ calendar: FSCalendar, numberOfEventsFor date: Date) -> Int {

        if self.eventsArray.contains(date) {
            return 1

        }
        if self.eventsArray_Done.contains(date) {
            return 1

        }
        return 0

    }

}

extension ChallengeViewController: FSCalendarDelegate {

    // 날짜 선택 시 콜백 메소드
    func calendar(_ calendar: FSCalendar,
                  didSelect date: Date,
                  at monthPosition: FSCalendarMonthPosition) {

        formatter.dateFormat = "yyyy-MM-dd"
        print(formatter.string(from: date) + " 선택됨")
    }
    // 날짜 선택 해제 시 콜백 메소드
    public func calendar(_ calendar: FSCalendar,
                         didDeselect date: Date,
                         at monthPosition: FSCalendarMonthPosition) {
        eventsArray = []
        print(formatter.string(from: date) + " 해제됨")

    }

}

extension ChallengeViewController: FSCalendarDelegateAppearance {

    func calendar(_ calendar: FSCalendar, cellFor date: Date, at position: FSCalendarMonthPosition) -> FSCalendarCell {

        let cell = calendar.dequeueReusableCell(withIdentifier: CalendarDateCell.identifier, for: date, at: position)

        return cell
    }

    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillSelectionColorFor date: Date) -> UIColor? {
        return .clear
    }

}
