//
//  ChallengeMainView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/21.
//

import UIKit
import Then
import SnapKit
import FSCalendar

class ChallengeMainView: UIView {

    var calendarHeight: NSLayoutConstraint!
    var buttonHeight: NSLayoutConstraint!

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
            $0.setImage(UIImage(named: "Expand"), for: .normal)
            $0.contentEdgeInsets = UIEdgeInsets(top: 10, left: 5, bottom: 10, right: 5)

        }

    var todayKeyWordView = TodayKeywordView()

    var stackView = UIStackView()
        .then {
            $0.axis = .vertical
            $0.spacing = 12
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
//            $0.handleScopeGesture().isEnabled/ = true
//            $0.scrollEnabled = false
//            $0.adjustsBoundingRectWhenChangingMonths = true
            $0.collectionView.register(CalendarDateCell.self, forCellWithReuseIdentifier: CalendarDateCell.identifier)
            // selection
            $0.appearance.todayColor = .clear
            $0.appearance.borderRadius = 5
            $0.select($0.today)
        }

    // TEMP
    var myChallengeCard = MyChallengeCard()
        .then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        layoutView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        layoutView()
    }

    func layoutView() {
        self.addSubview(subTitleLabel[0])
        subTitleLabel[0].snp.makeConstraints {
            $0.top.equalToSuperview().offset(7.0)
            $0.left.equalToSuperview().offset(20.0)

            // TEMP
            $0.right.equalToSuperview().offset(-20.0)
        }

        self.addSubview(calendarView)

        calendarView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel[0].snp.bottom).offset(15.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
        }
        calendarHeight = calendarView.heightAnchor.constraint(equalToConstant: 370)
        calendarHeight.isActive = true

        self.addSubview(expansionButton)

        expansionButton.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.width.equalTo(32)
            $0.height.equalTo(27)
            $0.bottom.equalTo(calendarView.snp.bottom).offset(-16)
        }

        self.addSubview(todayKeyWordView)
        todayKeyWordView.snp.makeConstraints {
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.top.equalTo(calendarView.snp.bottom).offset(9.0)
            $0.height.equalTo(177.0)
        }

        self.addSubview(subTitleLabel[1])
        subTitleLabel[1].snp.makeConstraints {
            $0.top.equalTo(todayKeyWordView.snp.bottom).offset(22.0)
            $0.left.equalToSuperview().offset(19.0)
            $0.right.equalToSuperview().offset(-19.0)
        }

        self.addSubview(stackView)
        stackView.snp.makeConstraints {
            $0.top.equalTo(subTitleLabel[1].snp.bottom).offset(12.0)
            $0.left.equalToSuperview().offset(20.0)
            $0.right.equalToSuperview().offset(-20.0)
            $0.bottom.equalToSuperview().offset(-20.0)
        }
    }

    func removeCard() {
        // 제대로 메모리 해제되는게 맞는지...
        while let first = stackView.arrangedSubviews.first {
            stackView.removeArrangedSubview(first)
            first.removeFromSuperview()
        }
    }

}
