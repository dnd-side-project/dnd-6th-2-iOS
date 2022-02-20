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
    var calendarHeight: NSLayoutConstraint!
    var buttonHeight: NSLayoutConstraint!
    var isMonth: Bool = false

    var scrollView = UIScrollView()
        .then {
            $0.showsVerticalScrollIndicator = false
        }

    // TODO: MAKING ROOM BUTTON
    var addWritingButton = UIButton()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.whitePurple)
        }

    var headerView = ChallengeHeaderView()

    var subTitleLabel = [
            UILabel().then {
                $0.text = "이번달은 n개의 O를 찍었어요!"
                $0.font = UIFont.pretendard(weight: .medium, size: 18)
                $0.textColor = .white
            },
            UILabel().then {
                $0.text = "내가 쓴 챌린지 글"
                $0.font = UIFont.pretendard(weight: .medium, size: 16)
                $0.textColor = .white
            }
        ]

    // TODO: Add dropdown

    var expansionButton = UIButton()
        .then {
            $0.setImage(UIImage(systemName: "heart.fill"), for: .normal)
        }

    var todayKeyWordView = TodayKeywordView()

    var stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 0
            $0.alignment = .fill
            $0.distribution = .fill
        }

    var calendarView = FSCalendar()
        .then {
            $0.backgroundColor = UIColor(rgb: Color.tag)
            $0.layer.cornerRadius = 15.0

            $0.locale = Locale(identifier: "ko_KR")
            $0.setScope(.week, animated: false)

            // header
            $0.calendarHeaderView.removeFromSuperview()
            // TEMP
            $0.headerHeight = 20

            // weekday
            $0.appearance.weekdayTextColor = UIColor(rgb: 0x767676)
            $0.appearance.weekdayFont = UIFont.pretendard(weight: .regular, size: 16)
            $0.weekdayHeight = 19.0

            // title
            $0.placeholderType = .fillHeadTail
            $0.appearance.titlePlaceholderColor = UIColor(rgb: 0x767676)
            $0.appearance.titleDefaultColor = UIColor(rgb: 0xE5E5E5)
            $0.appearance.titleFont = UIFont.pretendard(weight: .regular, size: 16)
            $0.rowHeight = 30

            // scroll
//            $0.handleScopeGesture().isEnabled = true
//            $0.scrollEnabled = false

            $0.collectionView.register(CalendarDateCell.self, forCellWithReuseIdentifier: CalendarDateCell.identifier)
            // selection
            $0.today = nil

            $0.appearance.borderRadius = 5
        }

    // TEMP
    var myChallengeCard = MyChallengeCard()
        .then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addWritingButton.layer.cornerRadius = addWritingButton.frame.size.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil

        calendarView.delegate = self
        calendarView.dataSource = self

        formatter.locale = Locale(identifier: "ko_KR")
        formatter.dateFormat = "yyyy-MM-dd"

        let xmas = formatter.date(from: "2022-2-21")
        let sampledate = formatter.date(from: "2022-3-30")
        eventsArray = [xmas!, sampledate!]

        setView()

        bindView()
    }

    func setView() {

        view.addSubview(headerView)
        headerView.snp.makeConstraints {
            $0.left.right.top.equalTo(view.safeAreaLayoutGuide)
        }

        view.addSubview(subTitleLabel[0])
        subTitleLabel[0].snp.makeConstraints {
            $0.top.equalTo(headerView.snp.bottom).offset(7.0)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20.0)

            // TEMP
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-20.0)
        }

        view.addSubview(calendarView)

        calendarView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel[0].snp.bottom).offset(15.0)
            $0.left.equalTo(view.safeAreaLayoutGuide).offset(20.0)
            $0.right.equalTo(view.safeAreaLayoutGuide).offset(-20.0)

        }
        calendarHeight = calendarView.heightAnchor.constraint(equalToConstant: UIScreen.main.bounds.width)
        calendarHeight.isActive = true

        view.addSubview(expansionButton)

        expansionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
        }

        buttonHeight = expansionButton.bottomAnchor.constraint(equalTo: calendarView.bottomAnchor)
        buttonHeight.constant = -11.0
        buttonHeight.isActive = true

        view.addSubview(todayKeyWordView)
        todayKeyWordView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(calendarView.snp.bottom).offset(9.0)
            $0.height.equalTo(177.0)
        }

        view.addSubview(subTitleLabel[1])
        subTitleLabel[1].snp.makeConstraints {
            $0.top.equalTo(todayKeyWordView.snp.bottom).offset(22.0)
            $0.left.equalToSuperview().offset(19.0)
            $0.right.equalToSuperview().offset(-19.0)
        }

        view.addSubview(stackView)
        stackView.addArrangedSubview(myChallengeCard)

        myChallengeCard.snp.makeConstraints {
            $0.width.equalToSuperview()
            $0.height.equalTo(166.0)
        }
        stackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel[1].snp.bottom).offset(12.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)

            // TEMP
            $0.bottom.equalTo(view.safeAreaLayoutGuide)
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

        expansionButton.rx.tap
            .withUnretained(self)
            .bind { owner, _ in
                if owner.isMonth {
                    owner.isMonth = false
                    owner.calendarView.setScope(.week, animated: true)
                    UIView.animate(withDuration: 10.0, delay: 0) {
                        owner.calendarHeight.constant = 144
                        owner.buttonHeight.constant = -11.0
                    }
                } else {
                    owner.isMonth = true
                    owner.calendarView.setScope(.month, animated: true)
                    UIView.animate(withDuration: 10.0, delay: 0) {
                        owner.calendarHeight.constant = UIScreen.main.bounds.width + 20
                        owner.buttonHeight.constant = -6.0
                    }

                }
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
    }

    private func goToBellNoticeVC() {

    }

    private func goToWritingVC() {
        let vc = WritingViewController()
        vc.modalPresentationStyle = .fullScreen
        vc.hidesBottomBarWhenPushed = true

        self.navigationController?.pushViewController(vc, animated: true)
    }

}

extension ChallengeViewController: FSCalendarDataSource {

    func calendar(_ calendar: FSCalendar,
                  boundingRectWillChange bounds: CGRect,
                  animated: Bool) {

        calendarHeight.constant = 144

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
}
