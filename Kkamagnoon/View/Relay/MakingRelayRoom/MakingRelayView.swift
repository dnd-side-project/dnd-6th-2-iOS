//
//  MakingRelayView.swift
//  Kkamagnoon
//
//  Created by 서정 on 2022/02/15.
//

import UIKit
import Then
import SnapKit
import RxSwift
import RxCocoa

class MakingRelayView: UIView {

    var disposeBag = DisposeBag()

    let backButton = UIButton()
        .then {
            $0.setImage(UIImage(named: "Back"), for: .normal)
            $0.imageEdgeInsets = UIEdgeInsets(top: 6, left: 0, bottom: 6, right: 18)
        }

    let titleLabel = UILabel()
        .then {
            $0.text = "릴레이방 만들기"
            $0.font = UIFont.pretendard(weight: .medium, size: 20)
            $0.textColor = .white
        }

    var stackView = UIStackView()
          .then {
              $0.axis = .vertical
              $0.spacing = 0
              $0.alignment = .fill
              $0.distribution = .fill
          }

    var subTitleLabelList: [UILabel] = [
        // 0
        UILabel().then {
            $0.text = "릴레이방 설정"
            $0.font = UIFont.pretendard(weight: .regular, size: 16)
            $0.textColor = UIColor(rgb: 0xECECEC)
            $0.setContentHuggingPriority(.required, for: .vertical)
        },
        // 1
        UILabel().then {
            $0.text = "제목"
            $0.font = UIFont.pretendard(weight: .regular, size: 16)
            $0.textColor = UIColor(rgb: 0xECECEC)
            $0.setContentHuggingPriority(.required, for: .vertical)
        },
        // 2
        UILabel().then {
            $0.text = "메인 공지사항"
            $0.font = UIFont.pretendard(weight: .medium, size: 16)
            $0.textColor = UIColor(rgb: 0xECECEC)
            $0.setContentHuggingPriority(.required, for: .vertical)
        },
        // 3
        UILabel().then {
            $0.text = "가장 위에 보여질 중요한 공지를 쓰는 곳이에요."
            $0.font = UIFont.pretendard(weight: .regular, size: 12)
            $0.textColor = UIColor(rgb: 0xC2C2C2)
            $0.setContentHuggingPriority(.required, for: .vertical)
        },
        // 4
        UILabel().then {
            $0.text = "인원"
            $0.font = UIFont.pretendard(weight: .regular, size: 16)
            $0.textColor = UIColor(rgb: 0xECECEC)
            $0.setContentHuggingPriority(.required, for: .vertical)
        }
    ]

    var addingTagView = AddingTagView()
        .then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

    var textViewList: [ShortTextView] = [
        ShortTextView(frame: .zero, textContainer: nil, placeholder: StringType.titlePlaceeholder).then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        },
        ShortTextView(frame: .zero, textContainer: nil, placeholder: StringType.noticePlaceholder).then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        },
        // DUMMY
        ShortTextView(frame: .zero, textContainer: nil, placeholder: StringType.noticePlaceholder).then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        }
    ]

    var settingPersonnelView = SettingPersonnelView()
        .then {
            $0.setContentHuggingPriority(.required, for: .vertical)
        }

    override init(frame: CGRect) {
        super.init(frame: frame)

        setBackButton()
        setTitleLabel()
        setStackView()
        setComponentView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)

        setBackButton()
        setTitleLabel()
        setStackView()
        setComponentView()
    }
}

extension MakingRelayView {
    func setBackButton() {

        self.addSubview(backButton)

        backButton.snp.makeConstraints {
            $0.left.equalToSuperview()
            $0.top.equalToSuperview().offset(26.24)
            $0.size.equalTo(26.0)
        }
    }

    func setTitleLabel() {
        self.addSubview(titleLabel)

        titleLabel.snp.makeConstraints {
            $0.centerY.equalTo(backButton)
            $0.left.equalTo(backButton.snp.right).offset(16.88)
            $0.right.equalToSuperview()
        }
    }

    func setStackView() {
        self.addSubview(stackView)

        stackView.addArrangedSubview(subTitleLabelList[0])

        stackView.addArrangedSubview(addingTagView)

        stackView.addArrangedSubview(subTitleLabelList[1])
        stackView.addArrangedSubview(textViewList[0])

        stackView.addArrangedSubview(subTitleLabelList[2])
        stackView.addArrangedSubview(subTitleLabelList[3])
        stackView.addArrangedSubview(textViewList[1])

        stackView.addArrangedSubview(subTitleLabelList[4])

        stackView.addArrangedSubview(settingPersonnelView)

        stackView.snp.makeConstraints {
            $0.top.equalTo(backButton.snp.bottom).offset(35.0)
            $0.left.right.bottom.equalToSuperview()
        }

        stackView.setCustomSpacing(14.0, after: subTitleLabelList[0])
        stackView.setCustomSpacing(24.0, after: addingTagView)
        stackView.setCustomSpacing(15.0, after: subTitleLabelList[1])

        stackView.setCustomSpacing(30.0, after: textViewList[0])
        stackView.setCustomSpacing(8.0, after: subTitleLabelList[2])
        stackView.setCustomSpacing(15.0, after: subTitleLabelList[3])
        stackView.setCustomSpacing(30.0, after: textViewList[1])

        stackView.setCustomSpacing(15.0, after: subTitleLabelList[4])

    }

    func setComponentView() {
        addingTagView.snp.makeConstraints {
            $0.height.equalTo(30.0)
        }

        textViewList[0].snp.makeConstraints {
            $0.height.equalTo(76.0)
        }

        textViewList[1].snp.makeConstraints {
            $0.height.equalTo(182.0)
        }

        settingPersonnelView.snp.makeConstraints {
            $0.height.equalTo(37.0)
        }

    }
}
