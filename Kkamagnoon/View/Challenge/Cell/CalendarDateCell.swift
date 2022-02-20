//
//  CalendarDateCell.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/20.
//

import UIKit
import SnapKit
import Then
import FSCalendar

class CalendarDateCell: FSCalendarCell {
    static let identifier = "CalendarDateCellIdentifier"

    var indicatorImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "Frame")
        }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setView() {

//        self.subviews.first?.backgroundColor = .orange
        self.subviews.first?.snp.makeConstraints {
            $0.height.equalTo(25)
            $0.top.equalToSuperview().offset(8)
            $0.left.right.equalToSuperview()
        }

        eventIndicator.subviews.first?.alpha = 0.0

//        eventIndicator.backgroundColor = .brown
        eventIndicator.snp.makeConstraints {
            $0.left.right.equalToSuperview()
            $0.top.equalTo(self.subviews.first?.snp.bottom as! ConstraintRelatableTarget)
            $0.height.equalTo(30)
        }

        eventIndicator.addSubview(indicatorImageView)

        indicatorImageView.snp.makeConstraints {
            $0.centerX.equalToSuperview()
            $0.top.equalToSuperview()

            $0.height.equalTo(25)
            $0.width.equalTo(25)
        }
    }
}
