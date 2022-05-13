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
import RxGesture

class ChallengeViewController: UIViewController {

    let viewModel = ChallengeViewModel()
    var disposeBag = DisposeBag()

    let formatter = DateFormatter()
        .then {
            $0.dateFormat = "EEE MMM dd yyyy"
        }

    var eventsArray = [Date]()
    var eventsArray_Done = [Date]()

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

    var nothingImageView = UIImageView()
        .then {
            $0.image = UIImage(named: "NothingCharacter")
        }

    var nothingLabel = UILabel()
        .then {
            $0.text = "오늘은 아직 글을\n쓰지 않았어요!"
            $0.numberOfLines = 0
            $0.textAlignment = .center
            $0.font = UIFont.pretendard(weight: .regular, size: 18)
            $0.textColor = UIColor(rgb: 0xF5F5F5)
        }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        addWritingButton.layer.cornerRadius = addWritingButton.frame.size.width / 2
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationController?.setNavigationBarHidden(true, animated: false)
        navigationController?.interactivePopGestureRecognizer?.delegate = nil
        view.backgroundColor = UIColor(rgb: Color.basicBackground)
        challengeMainView.calendarView.delegate = self
        challengeMainView.calendarView.dataSource = self

        setLayout()
        bindInput()
        bindOutput()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        viewModel.bindKeyword()

    }
}
